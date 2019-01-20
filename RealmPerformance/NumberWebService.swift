//
//  NumberWebService.swift
//
//  Copyright © 2019 Ark. All rights reserved.
//

import Foundation
import RealmSwift

public final class NumberWebService {
    public typealias Handler = () -> Void
    
    static let shared = NumberWebService()
    
    func storeRealmNumbers(amount: Int, completion: Handler? = nil) {
        let nums: [Int] = Array(0...amount)
        let realmIdentifiers = nums.compactMap { "\($0)" }
        let flyweights = realmIdentifiers.compactMap { NumberFlyweight(identifier: $0) }
        let realm = try! Realm()
        
        realm.save(items: flyweights, update: true) { _ in
            completion?()
        }
    }
}
