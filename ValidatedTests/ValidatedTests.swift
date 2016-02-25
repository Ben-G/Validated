//
//  ValidatedTests.swift
//  ValidatedTests
//
//  Created by Benji Encz on 2/24/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

import XCTest
import Validated

class ValidatedTests: XCTestCase {

    func testValidatesEmptyString() {
        // Define a type for a non-empty string
        typealias NonEmptyString = Validated<String, _NonEmptyString>
        // Create an empty string
        let valueNotValidated = NonEmptyString("")?.value
        XCTAssertNil(valueNotValidated)

        // Create a non-empty string
        let valueValidated = NonEmptyString("This is OK.")?.value
        XCTAssertEqual(valueValidated, "This is OK.")
    }

    func testValidatesCountGreater10() {
        // Define a type for a collection with more than 10 elements
        typealias MoreThan10ElementsIntArray = Validated<Array<Int>, _CountGreater10<[Int]>>

        let valueNotValidated = MoreThan10ElementsIntArray([1,2,3,4,5,6])?.value
        XCTAssertNil(valueNotValidated)

        let valueValidated = MoreThan10ElementsIntArray([1,2,3,4,5,6,7,8,9,10,11])?.value
        XCTAssertEqual(valueValidated!, [1,2,3,4,5,6,7,8,9,10,11])
    }

}
