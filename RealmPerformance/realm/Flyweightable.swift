//
//  Flyweightable.swift
//
//  Copyright © 2019 Ark. All rights reserved.

import Foundation

public protocol Flyweightable {
    associatedtype Flyweight

    func toFlyweight() -> Flyweight
}

