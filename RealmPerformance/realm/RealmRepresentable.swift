//
//  RealmRepresentable.swift
//
//  Copyright © 2019 Ark. All rights reserved.

import Foundation
import RealmSwift

public protocol RealmRepresentable {
    associatedtype RealmObject: Flyweightable
    
    func toRealm() -> RealmObject
}
