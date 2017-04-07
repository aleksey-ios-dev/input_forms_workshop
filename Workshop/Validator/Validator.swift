//
//  Validator.swift
//  Workshop
//
//  Created by Aleksey on 07.04.17.
//  Copyright © 2017 Jack Lapin. All rights reserved.
//

import Foundation

import UIKit

struct Validator<T> {
    
    var condition: (T) -> Bool
    
    func check(_ value: T) -> Bool {
        return condition(value)
    }
    
}

//String
func lengthEquals(_ length: Int) -> Validator<String> {
    return Validator { $0.characters.count == length }
}
func longerThan(_ length: Int) -> Validator<String> {
    return Validator { $0.characters.count > length }
}
func shorterThan(_ length: Int) -> Validator<String> {
    return Validator { $0.characters.count < length }
}
func containsString(_ otherString: String) -> Validator<String> {
    return Validator { $0.contains(otherString) }
}
func hasPrefix(_ prefix: String) -> Validator<String> {
    return Validator { $0.hasPrefix(prefix) }
}
func hasSuffix(_ suffix: String) -> Validator<String> {
    return Validator { $0.hasSuffix(suffix) }
}

//Collections
func contains<T>(_ element: T) -> Validator<[T]> where T: Equatable, T: Hashable {
    return Validator { Set($0).contains(element) }
}
func countEquals<T>(_ count: Int) -> Validator<[T]> {
    return Validator { $0.count == count }
}
func countMoreThan<T>(_ count: Int) -> Validator<[T]> {
    return Validator { $0.count > count }
}
func countLessThan<T>(_ count: Int) -> Validator<[T]> {
    return Validator { $0.count < count }
}

//Comparable & Equatable
func greaterThan<T: Comparable>(_ value: T) -> Validator<T> {
    return Validator { $0 > value }
}
func smallerThan<T: Comparable>(_ value: T) -> Validator<T> {
    return Validator { $0 < value }
}
func equal<T: Equatable>(to value: T) -> Validator<T> {
    return Validator { $0 == value }
}

//Date
func before(_ date: Date) -> Validator<Date> {
    return Validator { $0.compare(date) == .orderedAscending }
}

func after(_ date: Date) -> Validator<Date> {
    return Validator { $0.compare(date) == .orderedDescending }
}

func inTheFuture() -> Validator<Date> {
    return Validator { $0.compare(Date()) == .orderedDescending }
}

func inThePast() -> Validator<Date> {
    return Validator { $0.compare(Date()) == .orderedAscending }
}

//Int
func divisible(by divisor: Int) -> Validator<Int> {
    return Validator { $0 % divisor == 0 }
}

func any<T>(_ validators: [Validator<T>]) -> Validator<T> {
    return validators.reduce(Validator { _ in false }, { result, element in
        return result || element
    })
}

func all<T>(_ validators: [Validator<T>]) -> Validator<T> {
    return validators.reduce(Validator { _ in true }, { result, element in
        return result && element
    })
}

func none<T>(_ validators: [Validator<T>]) -> Validator<T> {
    return !any(validators)
}

func any<T, U>(_ rule: @escaping (U) -> Validator<T>, _ values: [U]) -> Validator<T> {
    return any(values.map { rule($0) })
}

func all<T, U>(_ rule: (U) -> Validator<T>, _ values: [U]) -> Validator<T> {
    return all(values.map { rule($0) })
}

func none<T, U>(_ rule: @escaping (U) -> Validator<T>, _ values: [U]) -> Validator<T> {
    return !any(rule, values)
}

func &&<T>(left: Validator<T>, right: Validator<T>) -> Validator<T> {
    return Validator<T> { left.check($0) && right.check($0) }
}

func ||<T>(left: Validator<T>, right: Validator<T>) -> Validator<T> {
    return Validator<T> { left.check($0) || right.check($0) }
}

func !=<T>(left: Validator<T>, right: Validator<T>) -> Validator<T> {
    return Validator<T> { left.check($0) != right.check($0) }
}

prefix func !<T>(left: Validator<T>) -> Validator<T> {
    return Validator<T> { !left.check($0) }
}
