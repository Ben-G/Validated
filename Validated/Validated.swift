//
//  Validated.swift
//  Validated
//
//  Created by Benji Encz on 2/24/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

/** 
This protocol needs to be implemented in order to add a requirement to
a wrapped type.

Implementers receive the wrapped type and need to determine if its values
fulfill the requirements of the wrapper type.

Example:

```
struct NonEmptyStringValidator: Validator {
    static func validate(value: String) -> Bool {
      if !value.isEmpty {
        return true
      } else {
        return false
      }
    }
}
```
*/
public protocol Validator {
    typealias WrappedType

    /// Validates if a value of the wrapped type fullfills the requirements of the
    /// wrapper type.
    ///
    /// - parameter validate: An instance of the `WrappedType`  
    /// - returns: A `Bool` indicating success(`true`)/failure(`false`) of the validation
    static func validate(value: WrappedType) -> Bool
}

/**
 Wraps a type together with one validator. Provides a failable initializer
 that will only return a value of `Validated` if the provided `WrapperType` value 
 fulfills the requirements of the specified `Validator`.
*/
public struct Validated<WrapperType, V: Validator where V.WrappedType == WrapperType> {
    public let value: WrapperType

    public init?(_ value: WrapperType) {
        if V.validate(value) {
            self.value = value
        } else {
            return nil
        }
    }
}

/**
 Wraps a type together with two validators. Provides a failable initializer
 that will only return a value of `Validated` if the provided `WrapperType` value
 fulfills the requirements of both specified `Validator` types.
 */
public struct Validated2<
    WrapperType,
    V1: Validator,
    V2: Validator where
        V1.WrappedType == WrapperType,
        V2.WrappedType == WrapperType> {
            public let value: WrapperType

            public init?(_ value: WrapperType) {
                if V1.validate(value) && V2.validate(value) {
                    self.value = value
                } else {
                    return nil
                }
            }
}

/**
 Wraps a type together with three validators. Provides a failable initializer
 that will only return a value of `Validated` if the provided `WrapperType` value
 fulfills the requirements of all three specified `Validator` types.
 */
public struct Validated3<
    WrapperType,
    V1: Validator,
    V2: Validator,
    V3: Validator where
        V1.WrappedType == WrapperType,
        V2.WrappedType == WrapperType,
        V3.WrappedType == WrapperType> {
    public let value: WrapperType

    public init?(_ value: WrapperType) {
        if V1.validate(value) && V2.validate(value) && V3.validate(value) {
            self.value = value
        } else {
            return nil
        }
    }
}

