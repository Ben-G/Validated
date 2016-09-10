//
//  ExampleValidators.swift
//  Validated
//
//  Created by Benji Encz on 2/24/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

@testable import Validated

// Example validators that are used throughout the unit tests. These should also be a good starting point for your custom `Validator` types.

struct EmptyStringValidator: Validator {
    static func validate(_ value: String) -> Bool {
        return value.isEmpty
    }
}

struct AllCapsLatinStringValidator: Validator {
    static func validate(_ value: String) -> Bool {
        return value.characters.reduce(true) { accumulator, character in
            return accumulator && ("A"..."Z").contains(character)
        }
    }
}

struct ContainsYorZ: Validator {
    static func validate(_ value: String) -> Bool {
        return value.characters.reduce(false) { accumulator, character in
            return accumulator || ("Y"..."Z").contains(character)
        }
    }
}

struct EmptyCollectionValidator<T: Collection>: Validator {
    static func validate(_ value: T) -> Bool {
        return value.isEmpty
    }
}

struct CountGreater10Validator<T: Collection>: Validator {
    static func validate(_ value: T) -> Bool {
        return value.count > 10
    }
}

struct SumLarger20Validator: Validator {
    static func validate(_ value: [Int]) -> Bool {
        return value.reduce(0, +) > 20
    }
}
