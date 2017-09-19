//
//  DestructuredDwifftTests.swift
//  DestructuredDwifftTests
//
//  Created by Robin Malhotra on 19/09/17.
//  Copyright © 2017 Robin Malhotra. All rights reserved.
//

import XCTest
import SwiftCheck
import Dwifft
import DestructuredDwifft

class DestructuredDwifftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func testDiff() {
		property("Diffing two arrays, then verify correct rows") <- forAll { (a1 : ArrayOf<Int>, a2 : ArrayOf<Int>) in
			let diff = Dwifft.diff(a1.getArray, a2.getArray)
			let diffRows = Set(diff.map{ $0.idx })
			
			let (inserts, deletes) = Dwifft.destructuredDiff(a1.getArray, a2.getArray, section: 1)
			let destructuredRows = Set(inserts.map{ $0.row } + deletes.map{ $0.row })
			
			return (diffRows == destructuredRows) <?> "diff applies"
		}
	}
	
	func testCorrectSection() {
		property("Diff 2 arrays, verify correct section") <- forAll { (a1: ArrayOf<Int>, a2: ArrayOf<Int>, section: Int) in
			let (inserts, deletes) = Dwifft.destructuredDiff(a1.getArray, a2.getArray, section: section)
			let nonSectionInserts = inserts.index(where: { (indexPath) -> Bool in
				return indexPath.section != section
			})
			
			let nonSectionDeletes = deletes.index(where: { (indexPath) -> Bool in
				return indexPath.section != section
			})
			return (nonSectionInserts == nil && nonSectionDeletes == nil)
		}
	}
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
