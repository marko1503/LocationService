//
//  LocationAuthorizationLevel.swift
//  LocationService
//
//  Created by Maksym Prokopchuk on 11/22/17.
//  Copyright © 2017 LocationService. All rights reserved.
//

import Foundation

/// Location authorization level you want to ask to the user
///
/// - always: always (both in background and foreground)
/// - whenInUse: only in foreground
public enum LocationAuthorizationLevel {
    case always
    case whenInUse
}

struct LocationAuthorizationLevelPlistKey: RawRepresentable, Equatable, Hashable {

    // MARK: - RawRepresentable
    typealias RawValue = String

    // MARK: - Init
    init(_ rawValue: RawValue) {
        self.rawValue = rawValue
    }

    init(rawValue: RawValue) {
        self.rawValue = rawValue
    }

    var rawValue: RawValue

    // MARK: - Hashable
    var hashValue: Int {
        return self.rawValue.hashValue
    }

    // MARK: - Equatable
    static func ==(lhs: LocationAuthorizationLevelPlistKey, rhs: LocationAuthorizationLevelPlistKey) -> Bool {
        guard lhs.rawValue == rhs.rawValue else { return false }
        return true
    }

}

extension LocationAuthorizationLevelPlistKey {

    static let onlyAlways = LocationAuthorizationLevelPlistKey("NSLocationAlwaysUsageDescription")
    static let onlyWhenInUse = LocationAuthorizationLevelPlistKey("NSLocationWhenInUseUsageDescription")
    static let alwaysAndWhenInUse = LocationAuthorizationLevelPlistKey("NSLocationAlwaysAndWhenInUseUsageDescription")

}
