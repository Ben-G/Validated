//
//  ValidatedTests.swift
//  ValidatedTests
//
//  Created by Benji Encz on 2/24/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

import XCTest
import Validated

/**
 The following tests use multiple example validators to ensure that invalid values
 cannot be constructed, while valid ones can be.
*/
class ValidatedTests: XCTestCase {

    // MARK: Basic Validate Tests

    func testValidatesEmptyString() {
        // Define a type for a non-empty string
        typealias NonEmptyString = Validated<String, Not<EmptyStringValidator>>
        // Create an empty string
        let valueNotValidated = NonEmptyString("")?.value
        XCTAssertNil(valueNotValidated)

        // Create a non-empty string
        let valueValidated = NonEmptyString("This is OK.")?.value
        XCTAssertEqual(valueValidated, "This is OK.")
    }

    func testValidatesAnyEmptyCollection() {
        // Define a type for a non-empty collection
        typealias NonEmptyListOfStrings = Validated<[String], Not<EmptyCollectionValidator<[String]>>>
        // Create an empty list of strings
        let valueNotValidated = NonEmptyListOfStrings([])?.value
        XCTAssertNil(valueNotValidated)

        let valueValidated = NonEmptyListOfStrings(["A", "B"])?.value
        XCTAssertEqual(valueValidated!, ["A", "B"])
    }

    func testSumLarger20() {
        // Define a type for an array of ints that has a sum larger 20
        typealias SumLarger20Array = Validated<[Int], SumLarger20Validator>

        let valueNotValidated = SumLarger20Array([8,8])?.value
        XCTAssertNil(valueNotValidated)

        let valueValidated = SumLarger20Array([8,8,8])?.value
        XCTAssertEqual(valueValidated!, [8,8,8])
    }

    // MARK: Generic Validator Tests

    func testValidatesCountGreater10() {
        // Define a type for a collection with more than 10 elements
        typealias MoreThan10ElementsIntArray = Validated<[Int], CountGreater10Validator<[Int]>>

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

    func testValidatesEmptyStringAndAllCaps1() {
        // Define a type for a non-empty all caps latin string
        typealias AllCapsNonEmptyString =
            Validated2<String, Not<EmptyStringValidator>, AllCapsLatinStringValidator>

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
            Validated2<[Int], CountGreater10Validator<[Int]>, SumLarger20Validator>

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

    // MARK: Validate3 Tests

    func testValidatesEmptyStringAndAllCapsContainsYorZ() {
        typealias AllCapsNonEmptyStringWithYorZ =
            Validated3<String, Not<EmptyStringValidator>, AllCapsLatinStringValidator, ContainsYorZ>

        // Create a non-complying string
        let valueNotValidated = AllCapsNonEmptyStringWithYorZ("ABCDEF")?.value
        XCTAssertNil(valueNotValidated)

        // Create a compying string
        let valueValidated = AllCapsNonEmptyStringWithYorZ("ABCDEFY")?.value
        XCTAssertEqual(valueValidated, "ABCDEFY")
    }
    
    // MARK: Validator And/Or/Not Tests

    func testValidatesEmptyStringAndAllCaps2() {
        // Define a type for a non-empty all caps latin string
        typealias AllCapsNonEmptyString =
            Validated<String, And<Not<EmptyStringValidator>, AllCapsLatinStringValidator>>

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
    
    func testValidatesEmptyStringOrAllCaps() {
        // Define a type for an empty or all caps latin string
        typealias AllCapsOrEmptyString =
            Validated<String, Or<EmptyStringValidator, AllCapsLatinStringValidator>>
        
        // Create an empty string
        let valueValidated1 = AllCapsOrEmptyString("")?.value
        XCTAssertEqual(valueValidated1, "")
        
        // Create a string with lowercase letters
        let valueNotValidated = AllCapsOrEmptyString("xYZcF")?.value
        XCTAssertNil(valueNotValidated)
        
        // Create an all caps string
        let valueValidated2 = AllCapsOrEmptyString("XYZCF")?.value
        XCTAssertEqual(valueValidated2, "XYZCF")
    }
    
    func testValidatesNonEmpty() {
        // Define a type for a non-empty string
        typealias AllCapsNonEmptyString =
            Validated<String, Not<EmptyStringValidator>>
        
        // Create an empty string
        let valueNotValidated = AllCapsNonEmptyString("")?.value
        XCTAssertNil(valueNotValidated)
        
        // Create an all caps string
        let valueValidated = AllCapsNonEmptyString("abC")?.value
        XCTAssertEqual(valueValidated, "abC")
    }

}
