//
//  CollectionPerformanceTests.swift
//
//  Copyright © 2019 Ark. All rights reserved.
//

import XCTest

class CollectionPerformanceTests: XCTestCase {
    private enum Constants {
        static let itemCount = 2500
    }
    
    // MARK: - Performance Tests
    
    func testEagerArrayPerformance() {
        let nums: [Int] = Array(0...Constants.itemCount)
        
        measure {
            for num in nums {
                XCTAssert(nums.filter { $0 == num }.first != nil)
            }
        }
    }
    
    func testLazyArrayPerformance() {
        let nums: [Int] = Array(0...Constants.itemCount)
        
        measure {
            for num in nums {
                XCTAssert(nums.first(where: { $0 == num }) != nil)
            }
        }
    }
    
    func testSetRetrievalPerformance() {
        let nums: Set<Int> = Set(0...Constants.itemCount)
        
        measure {
            for num in nums {
                XCTAssert(nums.first(where: { $0 == num }) != nil )
            }
        }
    }
    
    func testSetExistencePerformance() {
        let nums: Set<Int> = Set(0...Constants.itemCount)
        
        measure {
            for num in nums {
                XCTAssert(nums.contains(num))
            }
        }
    }
}
