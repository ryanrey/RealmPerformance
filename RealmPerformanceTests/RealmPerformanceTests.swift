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
        static let itemCount = 5000
    }
    
    override func setUp() {
        numberWebService.storeRealmNumbers(amount: Constants.itemCount)
    }

    override func tearDown() {
        deleteRealmObjects()
    }
    
    // MARK: - Performance Tests
    
    func testRepositoryOnePerformance() {
        let repository: Repository = RepositoryOne()
        
        measure {
            for num in 0...Constants.itemCount {
                let identifier = "\(num)"
                let number = repository.getNumber(id: identifier)
                
                XCTAssert(number != nil)
            }
        }
    }
    
    func testRepositoryTwoPerformance() {
        let repository: Repository = RepositoryTwo()
        
        measure {
            for num in 0...Constants.itemCount {
                let identifier = "\(num)"
                let number = repository.getNumber(id: identifier)
                
                XCTAssert(number != nil)
            }
        }
    }
    
    func testRepositoryThreePerformance() {
        let repository: Repository = RepositoryThree()
        
        measure {
            for num in 0...Constants.itemCount {
                let identifier = "\(num)"
                let number = repository.getNumber(id: identifier)
                
                XCTAssert(number != nil)
            }
        }
    }
    
    func testRepositoryFourPerformance() {
        let repository: Repository = RepositoryFour()
        
        measure {
            for num in 0...Constants.itemCount {
                let identifier = "\(num)"
                let number = repository.getNumber(id: identifier)
                
                XCTAssert(number != nil)
            }
        }
    }
    
    func testRepositoryFivePerformance() {
        let repository: Repository = RepositoryFive()
        
        measure {
            for num in 0...Constants.itemCount {
                let identifier = "\(num)"
                let number = repository.getNumber(id: identifier)
                
                XCTAssert(number != nil)
            }
        }
    }
    
    // MARK: - Private
    
    private func deleteRealmObjects() {
        let realm = try! Realm()
        realm.deleteAllObjects()
    }
}
