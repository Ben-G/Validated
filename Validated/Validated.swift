//
//  Validated.swift
//  Validated
//
//  Created by Benji Encz on 2/24/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

public protocol Validator {
    typealias WrappedType

    static func validate(value: WrappedType) -> Bool
}

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

