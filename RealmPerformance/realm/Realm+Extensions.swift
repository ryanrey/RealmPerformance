//
//  Realm+Extensions.swift
//

import Foundation
import RealmSwift

extension Realm {
    func save<T: RealmRepresentable>(item: T, update: Bool = true, completion: ((T.RealmObject?) -> Void)? = nil) where T.RealmObject: Object  {
        do {
            try write {
                let realmObject: T.RealmObject = item.toRealm()
                add(realmObject, update: update)
                try commitWrite()
                completion?(realmObject)
            }
        } catch {
            completion?(nil)
        }
    }
    
    func save<T: RealmRepresentable>(items: [T], update: Bool = true, completion: (([T.RealmObject]) -> Void)? = nil) where T.RealmObject: Object  {
        autoreleasepool {
            do {
                try write {
                    let realmObjects: [T.RealmObject] = items.compactMap { $0.toRealm() }
                    add(realmObjects, update: update)
                    try commitWrite()
                    // refresh()
                    completion?(realmObjects)
                }
            } catch {
                completion?([])
            }
        }
    }
}


extension Realm {
    func deleteAllObjects(_ completion: (() -> Void)? = nil) {
        beginWrite()
        deleteAll()
        
        do {
            try commitWrite()
            completion?()
        } catch {
            completion?()
        }
    }
}
