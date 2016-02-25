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

    // MARK: Basic Validate Tests

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

    func testSumLarger20() {
        // Define a type for an array of ints that has a sum larger 20
        typealias SumLarger20Array = Validated<[Int], _SumLarger20>

        let valueNotValidated = SumLarger20Array([8,8])?.value
        XCTAssertNil(valueNotValidated)

        let valueValidated = SumLarger20Array([8,8,8])?.value
        XCTAssertEqual(valueValidated!, [8,8,8])
    }

    // MARK: Generic Validator Tests

    func testValidatesCountGreater10() {
        // Define a type for a collection with more than 10 elements
        typealias MoreThan10ElementsIntArray = Validated<[Int], _CountGreater10<[Int]>>

        let valueNotValidated = MoreThan10ElementsIntArray([1,2,3,4,5,6])?.value
        XCTAssertNil(valueNotValidated)

        let valueValidated = MoreThan10ElementsIntArray([1,2,3,4,5,6,7,8,9,10,11])?.value
        XCTAssertEqual(valueValidated!, [1,2,3,4,5,6,7,8,9,10,11])
    }

    // MARK: Custom Type Tests

    func testValidatesLoggedInUser() {
        // Define a type for a logged in user
        typealias LoggedInUser = Validated<User, LoggedInValidator>

        let valueNotValidated = LoggedInUser(
            User(username: "User", loggedIn: false)
        )?.value
        XCTAssertNil(valueNotValidated)

        let valueValidated = LoggedInUser(
            User(username: "User", loggedIn: true)
        )?.value
        XCTAssertEqual(valueValidated?.username, "User")
    }

    // MARK: Validate2 Tests

    func testValidatesEmptyStringAndAllCaps() {
        // Define a type for a non-empty all caps latin string
        typealias AllCapsNonEmptyString =
            Validated2<String, _NonEmptyString, _AllCapsLatinString>

        // Create an empty string
        let valueNotValidated = AllCapsNonEmptyString("")?.value
        XCTAssertNil(valueNotValidated)

        // Create a string with lowercase letters
        let valueNotValidated2 = AllCapsNonEmptyString("xYZcF")?.value
        XCTAssertNil(valueNotValidated2)

        // Create an all caps string
        let valueValidated = AllCapsNonEmptyString("XYZCF")?.value
        XCTAssertEqual(valueValidated, "XYZCF")
    }

    func testValidatesCountGreater10AndSumLarger20() {
        typealias MoreThan10ElementsWithSumGreater20 =
            Validated2<[Int], _CountGreater10<[Int]>, _SumLarger20>

        let valueNotValidated = MoreThan10ElementsWithSumGreater20([100,2,400,5,6])?.value
        XCTAssertNil(valueNotValidated)

        let valueNotValidated2 = MoreThan10ElementsWithSumGreater20(
            [1,1,1,1,1,1,1,1,1,1,1,1,1,1]
        )?.value
        XCTAssertNil(valueNotValidated2)

        let valueValidated = MoreThan10ElementsWithSumGreater20(
            [100,1,1,1,1,1,1,1,1,1,1,1,1,100]
        )?.value
        XCTAssertEqual(valueValidated!, [100,1,1,1,1,1,1,1,1,1,1,1,1,100])
    }

}
