//
//  Validated.swift
//  Validated
//
//  Created by Benji Encz on 2/24/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

/// This protocol needs to be implemented in order to add a requirement to
/// a wrapped type.
/// Implementers receive the wrapped type and need to determine if its values
/// fulfill the requirements of the wrapper type.
/// ~~~
/// struct NonEmptyStringValidator: Validator {
///     static func validate(value: String) -> Bool {
///         return !value.isEmpty
///     }
/// }
/// ~~~
public protocol Validator {
    typealias WrappedType

    /// Validates if a value of the wrapped type fullfills the requirements of the
    /// wrapper type.
    ///
    /// - parameter validate: An instance of the `WrappedType`
    /// - returns: A `Bool` indicating success(`true`)/failure(`false`) of the validation
    static func validate(value: WrappedType) -> Bool
}

/// Wraps a type together with one validator. Provides a failable initializer
/// that will only return a value of `Validated` if the provided `WrapperType` value
/// fulfills the requirements of the specified `Validator`.
public struct Validated<WrapperType, V: Validator where V.WrappedType == WrapperType> {
    /// The value that passes the defined `Validator`.
    ///
    /// If you are able to access this property; it means the wrappedType passes the validator.
    public let value: WrapperType

    /// Failible initializer that will only succeed if the provided value fulfills the requirements specified by the `Validator`.
    public init?(_ value: WrapperType) {
        guard V.validate(value) else { return nil }
        self.value = value
    }
}

/// Wraps a type together with two validators. Provides a failable initializer
/// that will only return a value of `Validated` if the provided `WrapperType` value
/// fulfills the requirements of both specified `Validator` types.
public struct Validated2<
    WrapperType,
    V1: Validator,
    V2: Validator where
        V1.WrappedType == WrapperType,
        V2.WrappedType == WrapperType> {
    /// The value that passes the two provided `Validator`s.
    public let value: WrapperType

    /// Failible initializer that will only succeed if the provided value fulfills the requirements specified by the `Validator`s.
    public init?(_ value: WrapperType) {
        guard V1.validate(value) && V2.validate(value) else { return nil }
        self.value = value
    }
}

/// Wraps a type together with three validators. Provides a failable initializer
/// that will only return a value of `Validated` if the provided `WrapperType` value
/// fulfills the requirements of all three specified `Validator` types.
public struct Validated3<
    WrapperType,
    V1: Validator,
    V2: Validator,
    V3: Validator where
        V1.WrappedType == WrapperType,
        V2.WrappedType == WrapperType,
        V3.WrappedType == WrapperType> {
    /// The value that passes the three provided `Validator`s.
    public let value: WrapperType

    /// Failable initializer that will only succeed if the provided value fulfills the requirements specified by the `Validator`s.
    public init?(_ value: WrapperType) {
        guard V1.validate(value) && V2.validate(value) && V3.validate(value) else { return nil }
        self.value = value
    }
}

/// Validator wrapper which is valid when `V1` and `V2` validated to `true`.
public struct And<
    V1: Validator,
    V2: Validator where
        V1.WrappedType == V2.WrappedType>: Validator {
    public static func validate(value: V1.WrappedType) -> Bool {
        return V1.validate(value) && V2.validate(value)
    }
}

/// Validator wrapper which is valid when either `V1` or `V2` validated to `true`.
public struct Or<
    V1: Validator,
    V2: Validator where
        V1.WrappedType == V2.WrappedType>: Validator {
    public static func validate(value: V1.WrappedType) -> Bool {
        return V1.validate(value) || V2.validate(value)
    }
}

/// Validator wrapper which is valid when `V1` validated to `false`.
public struct Not<V1: Validator>: Validator {
    public static func validate(value: V1.WrappedType) -> Bool {
        return !V1.validate(value)
    }
}
