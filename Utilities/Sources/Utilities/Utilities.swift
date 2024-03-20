//
//  Utilities.swift
//
//
//  Created by Rayhan Nabi on 19/3/24.
//

public func clamp<T>(_ value: T, in range: ClosedRange<T>) -> T where T: Comparable {
  min(max(value, range.lowerBound), range.upperBound)
}
