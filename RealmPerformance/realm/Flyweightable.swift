//
//  Flyweightable.swift
//

import Foundation

protocol Flyweightable {
    associatedtype Flyweight

    func toFlyweight() -> Flyweight
}

