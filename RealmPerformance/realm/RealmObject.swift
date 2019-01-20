//
//  RealmObject.swift
//

import Foundation
import RealmSwift

// Realm Objects that conform to RealmObject
protocol RealmObject {
    associatedtype IDType
    
    static func uniqueKey() -> String?
    
    func uniqueID() -> IDType?
}

extension RealmObject where Self: Object {
    static func uniqueKey() -> String? {
        guard let primaryKey = primaryKey() else { assertionFailure(); return "" }
        
        return primaryKey
    }
    
    func uniqueID() -> Int? {
        return nil
    }
    
    static func fetchObject(byIdentifier identifier: IDType, inRealm realm: Realm) -> Self? {
        guard uniqueKey() != nil else { return nil }
        
        return realm.object(ofType: self, forPrimaryKey: identifier as AnyObject)
    }
    
    static func fetchObject(byIdentifier identifier: IDType) -> Self? {
        guard let realm = try? Realm() else { return nil }
        
        return fetchObject(byIdentifier: identifier, inRealm: realm)
    }
    
    static func fetchObjects(byIdentifiers identifiers: [IDType], inRealm realm: Realm) -> [Self] {
        let references = identifiers.compactMap { fetchObject(byIdentifier: $0, inRealm: realm) }
        return references
    }
    
    static func fetchObjects(byIdentifiers identifiers: [IDType]) -> [Self] {
        guard let realm = try? Realm() else { return [] }
        
        let references = identifiers.compactMap { fetchObject(byIdentifier: $0, inRealm: realm) }
        return references
    }
}
