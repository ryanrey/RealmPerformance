//
//  NumberRealmObject.swift
//

import Foundation
import RealmSwift
import UIKit

public protocol NumberModel: class {
    var identifier: String? { get set }
}

extension NumberModel {
    func update(withNumberModel model: NumberModel) {
        identifier = model.identifier
    }
}

public class NumberFlyweight: NumberModel {
    public var identifier: String?
    
    init(identifier: String? = nil) {
        self.identifier = identifier
    }
}

extension NumberRealmObject: Flyweightable {
    typealias Flyweight = NumberFlyweight
    
    public func toFlyweight() -> NumberFlyweight {
        let flyweight = NumberFlyweight()
        flyweight.update(withNumberModel: self)
        
        return flyweight
    }
}

extension NumberFlyweight: RealmRepresentable {
    typealias RealmObject = NumberRealmObject
    
    public func toRealm() -> NumberRealmObject {
        let realm = try! Realm()
        
        if let numberRealmObject = realm.object(ofType: NumberRealmObject.self, forPrimaryKey: identifier as AnyObject) {
            return numberRealmObject
        }
        
        let numberRealmObject = NumberRealmObject()
        numberRealmObject.update(withNumberModel: self)
        
        return numberRealmObject
    }
}

extension NumberRealmObject: RealmObject {
    static func uniqueKey() -> String? {
        return "identifier"
    }
    
    func uniqueID() -> String? {
        return "identifier"
    }
}

public class NumberRealmObject: Object, NumberModel {
    @objc public dynamic var identifier: String?
    
    @objc open override class func primaryKey() -> String? {
        return uniqueKey()
    }
}
