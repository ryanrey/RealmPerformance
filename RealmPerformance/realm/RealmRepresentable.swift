//
//  RealmRepresentable.swift
//

import Foundation
import RealmSwift

protocol RealmRepresentable {
    associatedtype RealmObject: Flyweightable
    
    func toRealm() -> RealmObject
}
