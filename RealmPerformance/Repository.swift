//
//  Repository.swift
//
//  Copyright © 2019 Ark. All rights reserved.
//

import Foundation
import RealmSwift

public protocol Repository {
    func getNumber(id: String) -> NumberRealmObject?
}

// The concrete Repository instances listed here are in order from least to most performant

public final class RepositoryOne: Repository {
    private var results: Results<NumberRealmObject> {
        let realm = try! Realm()
        
        return realm.objects(NumberRealmObject.self)
    }
    
    public func getNumber(id: String) -> NumberRealmObject? {
        return Array(results).first(where: { $0.identifier == id })
    }
}


public final class RepositoryTwo: Repository {
    private var results: Results<NumberRealmObject> {
        let realm = try! Realm()
        
        return realm.objects(NumberRealmObject.self)
    }
    
    public func getNumber(id: String) -> NumberRealmObject? {
        return results.first(where: { $0.identifier == id })
    }
}


public final class RepositoryThree: Repository {
    private var results: Results<NumberRealmObject> {
        let realm = try! Realm()
        
        return realm.objects(NumberRealmObject.self)
    }
    
    public func getNumber(id: String) -> NumberRealmObject? {
        let predicate = NSPredicate(format: "identifier = %@", id)
        
        return results.filter(predicate).first
    }
}


public final class RepositoryFour: Repository {
    private lazy var realm = try! Realm()
    private lazy var results = self.realm.objects(NumberRealmObject.self)
   
    public func getNumber(id: String) -> NumberRealmObject? {
        let predicate = NSPredicate(format: "identifier = %@", id)
        
        return results.filter(predicate).first
    }
}


public final class RepositoryFive: Repository {
    public func getNumber(id: String) -> NumberRealmObject? {
        let realm = try! Realm()
        let realmObject = realm.object(ofType: NumberRealmObject.self, forPrimaryKey: id as AnyObject)
        
        return realmObject
    }
}
