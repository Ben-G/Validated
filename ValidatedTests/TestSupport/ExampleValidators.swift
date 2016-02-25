//
//  ExampleValidators.swift
//  Validated
//
//  Created by Benji Encz on 2/24/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

@testable import Validated

/**
 Example validators that are used throughout the unit tests.
 These should also be a good starting point for your custom `Validator` types.
 */

struct NonEmptyStringValidator: Validator {
    static func validate(value: String) -> Bool {
        if !value.isEmpty {
            return true
        } else {
            return false
        }
    }
}

struct AllCapsLatinStringValidator: Validator {
    static func validate(value: String) -> Bool {
        return value.characters.reduce(true) { accumulator, character in
            return accumulator && ("A"..."Z").contains(character)
        }
    }
}

struct ContainsYorZ: Validator {
    static func validate(value: String) -> Bool {
        return value.characters.reduce(false) { accumulator, character in
            return accumulator || ("Y"..."Z").contains(character)
        }
    }
}

struct NonEmptyCollectionValidator<T: CollectionType>: Validator {
    static func validate(value: T) -> Bool {
        if !value.isEmpty {
            return true
        } else {
            return false
        }
    }
}

struct CountGreater10Validator<T: CollectionType>: Validator {
    static func validate(value: T) -> Bool {
        if value.count > 10 {
            return true
        } else {
            return false
        }
    }
}

struct SumLarger20Validator: Validator {
    static func validate(value: [Int]) -> Bool {
        if value.reduce(0, combine: +) > 20 {
            return true
        } else {
            return false
        }
    }
}
