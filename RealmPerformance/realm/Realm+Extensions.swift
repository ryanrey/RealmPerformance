//
//  Realm+Extensions.swift
//
//  Copyright © 2019 Ark. All rights reserved.

import Foundation
import RealmSwift

extension Realm {
    public func save<T: RealmRepresentable>(item: T, update: Bool = true, completion: ((T.RealmObject?) -> Void)? = nil) where T.RealmObject: Object  {
        do {
            try write {
                let realmObject: T.RealmObject = item.toRealmObject()
                add(realmObject, update: update)
                
                completion?(realmObject)
            }
        } catch {
            completion?(nil)
        }
    }
    
    public func save<T: RealmRepresentable>(items: [T], update: Bool = true, completion: (([T.RealmObject]) -> Void)? = nil) where T.RealmObject: Object  {
        autoreleasepool {
            do {
                try write {
                    let realmObjects: [T.RealmObject] = items.compactMap { $0.toRealmObject() }
                    add(realmObjects, update: update)
                    
                    completion?(realmObjects)
                }
            } catch {
                completion?([])
            }
        }
    }
}


extension Realm {
    public func deleteAllObjects(_ completion: (() -> Void)? = nil) {
        do {
            try write {
                deleteAll()
                completion?()
            }
        } catch {
            completion?()
        }
    }
}
