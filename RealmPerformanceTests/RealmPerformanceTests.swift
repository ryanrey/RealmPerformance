//
//  RealmPerformanceTests.swift
//
//  Copyright © 2019 Ark. All rights reserved.
//

import XCTest
import RealmSwift
@testable import RealmPerformance

class RealmPerformanceTests: XCTestCase {
    let numberWebService = NumberWebService.shared
    
    private enum Constants {
        static let itemCount = 10000
    }
    
    override func setUp() {
        numberWebService.downloadAndStoreRealmNumbers(amount: Constants.itemCount)
    }

    override func tearDown() {
         let realm = try! Realm()
         realm.deleteAllObjects()
    }

    func testStoreRealmObjects() {
        let realm = try! Realm()
        realm.deleteAllObjects()
        
        measure {
            numberWebService.downloadAndStoreRealmNumbers(amount: Constants.itemCount)
        }
    }
    
    func testRepositoryOne() {
        let repository: Repository = RepositoryOne()
        
        measure {
            for num in 0...Constants.itemCount {
                let identifier = "\(num)"
                let number = repository.getNumber(id: identifier)
                assert(number != nil)
            }
        }
    }
    
    func testRepositoryTwo() {
        let repository: Repository = RepositoryTwo()
        
        measure {
            for num in 0...Constants.itemCount {
                let identifier = "\(num)"
                let number = repository.getNumber(id: identifier)
                assert(number != nil)
            }
        }
    }
    
    func testRepositoryThree() {
        let repository: Repository = RepositoryThree()
        
        measure {
            for num in 0...Constants.itemCount {
                let identifier = "\(num)"
                let number = repository.getNumber(id: identifier)
                assert(number != nil)
            }
        }
    }
    
    func testRepositoryFour() {
        let repository: Repository = RepositoryFour()
        
        measure {
            for num in 0...Constants.itemCount {
                let identifier = "\(num)"
                let number = repository.getNumber(id: identifier)
                assert(number != nil)
            }
        }
    }
    
    func testRepositoryFive() {
        let repository: Repository = RepositoryFive()
        
        measure {
            for num in 0...Constants.itemCount {
                let identifier = "\(num)"
                let number = repository.getNumber(id: identifier)
                assert(number != nil)
            }
        }
    }
}
