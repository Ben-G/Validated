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
        let valueNotValidated = NonEmptyString(value: "")?.value
        XCTAssertNil(valueNotValidated)

        // Create a non-empty string
        let valueValidated = NonEmptyString(value: "This is OK.")?.value
        XCTAssertEqual(valueValidated, "This is OK.")
    }

    func testValidatesAnyEmptyCollection() {
        // Define a type for a non-empty collection
        typealias NonEmptyListOfStrings = Validated<[String], Not<EmptyCollectionValidator<[String]>>>
        // Create an empty list of strings
        let valueNotValidated = NonEmptyListOfStrings(value: [])?.value
        XCTAssertNil(valueNotValidated)

        let valueValidated = NonEmptyListOfStrings(value: ["A", "B"])?.value
        XCTAssertEqual(valueValidated!, ["A", "B"])
    }

    func testSumLarger20() {
        // Define a type for an array of ints that has a sum larger 20
        typealias SumLarger20Array = Validated<[Int], SumLarger20Validator>

        let valueNotValidated = SumLarger20Array(value: [8,8])?.value
        XCTAssertNil(valueNotValidated)

        let valueValidated = SumLarger20Array(value: [8,8,8])?.value
        XCTAssertEqual(valueValidated!, [8,8,8])
    }

    // MARK: Generic Validator Tests

    func testValidatesCountGreater10() {
        // Define a type for a collection with more than 10 elements
        typealias MoreThan10ElementsIntArray = Validated<[Int], CountGreater10Validator<[Int]>>

        let valueNotValidated = MoreThan10ElementsIntArray(value: [1,2,3,4,5,6])?.value
        XCTAssertNil(valueNotValidated)

        let valueValidated = MoreThan10ElementsIntArray(value: [1,2,3,4,5,6,7,8,9,10,11])?.value
        XCTAssertEqual(valueValidated!, [1,2,3,4,5,6,7,8,9,10,11])
    }

    // MARK: Custom Type Tests

    func testValidatesLoggedInUser() {
        // Define a type for a logged in user
        typealias LoggedInUser = Validated<User, LoggedInValidator>

        let valueNotValidated = LoggedInUser(
            value: User(username: "User", loggedIn: false)
        )?.value
        XCTAssertNil(valueNotValidated)

        let valueValidated = LoggedInUser(
            value: User(username: "User", loggedIn: true)
        )?.value
        XCTAssertEqual(valueValidated?.username, "User")
    }

    // MARK: 2 Validator Test

    func testValidatesEmptyStringAndAllCaps1() {
        // Define a type for a non-empty all caps latin string
        typealias AllCapsNonEmptyString =
            Validated<String, And<Not<EmptyStringValidator>, AllCapsLatinStringValidator>>

        // Create an empty string
        let valueNotValidated = AllCapsNonEmptyString(value: "")?.value
        XCTAssertNil(valueNotValidated)

        // Create a string with lowercase letters
        let valueNotValidated2 = AllCapsNonEmptyString(value: "xYZcF")?.value
        XCTAssertNil(valueNotValidated2)

        // Create an all caps string
        let valueValidated = AllCapsNonEmptyString(value: "XYZCF")?.value
        XCTAssertEqual(valueValidated, "XYZCF")
    }

    func testValidatesCountGreater10AndSumLarger20() {
        typealias MoreThan10ElementsWithSumGreater20 =
            Validated<[Int], And<CountGreater10Validator<[Int]>, SumLarger20Validator>>

        let valueNotValidated = MoreThan10ElementsWithSumGreater20(value: [100,2,400,5,6])?.value
        XCTAssertNil(valueNotValidated)

        let valueNotValidated2 = MoreThan10ElementsWithSumGreater20(
            value: [1,1,1,1,1,1,1,1,1,1,1,1,1,1]
        )?.value
        XCTAssertNil(valueNotValidated2)

        let valueValidated = MoreThan10ElementsWithSumGreater20(
            value: [100,1,1,1,1,1,1,1,1,1,1,1,1,100]
        )?.value
        XCTAssertEqual(valueValidated!, [100,1,1,1,1,1,1,1,1,1,1,1,1,100])
    }

    // MARK: 3 Validator Test

    func testValidatesEmptyStringAndAllCapsContainsYorZ() {
        typealias AllCapsNonEmptyStringWithYorZ =
            Validated<String, And<And<Not<EmptyStringValidator>, AllCapsLatinStringValidator>, ContainsYorZ>>

        // Create a non-complying string
        let valueNotValidated = AllCapsNonEmptyStringWithYorZ(value: "ABCDEF")?.value
        XCTAssertNil(valueNotValidated)

        // Create a compying string
        let valueValidated = AllCapsNonEmptyStringWithYorZ(value: "ABCDEFY")?.value
        XCTAssertEqual(valueValidated, "ABCDEFY")
    }
    
    // MARK: Validator And/Or/Not Tests

    func testValidatesEmptyStringAndAllCaps2() {
        // Define a type for a non-empty all caps latin string
        typealias AllCapsNonEmptyString =
            Validated<String, And<Not<EmptyStringValidator>, AllCapsLatinStringValidator>>

        // Create an empty string
        let valueNotValidated = AllCapsNonEmptyString(value: "")?.value
        XCTAssertNil(valueNotValidated)

        // Create a string with lowercase letters
        let valueNotValidated2 = AllCapsNonEmptyString(value: "xYZcF")?.value
        XCTAssertNil(valueNotValidated2)

        // Create an all caps string
        let valueValidated = AllCapsNonEmptyString(value: "XYZCF")?.value
        XCTAssertEqual(valueValidated, "XYZCF")
    }
    
    func testValidatesEmptyStringOrAllCaps() {
        // Define a type for an empty or all caps latin string
        typealias AllCapsOrEmptyString =
            Validated<String, Or<EmptyStringValidator, AllCapsLatinStringValidator>>
        
        // Create an empty string
        let valueValidated1 = AllCapsOrEmptyString(value: "")?.value
        XCTAssertEqual(valueValidated1, "")
        
        // Create a string with lowercase letters
        let valueNotValidated = AllCapsOrEmptyString(value: "xYZcF")?.value
        XCTAssertNil(valueNotValidated)
        
        // Create an all caps string
        let valueValidated2 = AllCapsOrEmptyString(value: "XYZCF")?.value
        XCTAssertEqual(valueValidated2, "XYZCF")
    }
    
    func testValidatesNonEmpty() {
        // Define a type for a non-empty string
        typealias AllCapsNonEmptyString =
            Validated<String, Not<EmptyStringValidator>>
        
        // Create an empty string
        let valueNotValidated = AllCapsNonEmptyString(value: "")?.value
        XCTAssertNil(valueNotValidated)
        
        // Create an all caps string
        let valueValidated = AllCapsNonEmptyString(value: "abC")?.value
        XCTAssertEqual(valueValidated, "abC")
    }

    // MARK: Error Handling Tests

    func testThrowingInitializer() {
        // Define a type for a non-empty string
        typealias NonEmptyString = Validated<String, Not<EmptyStringValidator>>
        // Create an empty string
        do {
            _ = try NonEmptyString("").value
        } catch let error as ValidatorError {
            XCTAssertTrue(error.validator == Not<EmptyStringValidator>.self)
            XCTAssertTrue(error.wrapperValue as! String == "")
            XCTAssertEqual(
                error.description,
                "Value: '' <String>, failed validation of Validator: Not<EmptyStringValidator>"
            )
        } catch {}

        // Create a non-empty string
        let valueValidated = try! NonEmptyString("This is OK.").value
        XCTAssertEqual(valueValidated, "This is OK.")
    }
}
