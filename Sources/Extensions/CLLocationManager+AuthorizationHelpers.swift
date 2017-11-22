//
//  CLLocationManager+AuthorizationHelpers.swift
//  LocationService
//
//  Created by Maksym Prokopchuk on 11/22/17.
//  Copyright © 2017 LocationService. All rights reserved.
//

import Foundation
import CoreLocation


public extension CLLocationManager {

//    /// Returns the current state of heading services for this device.
//    public var headingState: HeadingServiceState {
//        return (CLLocationManager.headingAvailable() ? .available : .unavailable)
//    }

//    /// Return `true` if host application has background location capabilities enabled
//    public static var hasBackgroundCapabilities: Bool {
//        guard let capabilities = Bundle.main.infoDictionary?["UIBackgroundModes"] as? [String] else {
//            return false
//        }
//        return capabilities.contains("location")
//    }

    /// Return the highest authorization level based upon the value added info applications'
    /// Info.plist file.
    public static var locationAuthorizationLevelFromInfoPlist: LocationAuthorizationLevel {
        var level: LocationAuthorizationLevel
        let bundle: Bundle = Bundle.main

        if #available(iOS 11.0, *) {
            // In iOS11 stuff are changed again
            let key = LocationAuthorizationLevelPlistKey.alwaysAndWhenInUse.rawValue
            let hasAlwaysAndInUseKey = bundle.hasInfoPlistValue(forKey: key)
            if hasAlwaysAndInUseKey == true {
                level = .always
            }
            else {
                fatalError("To use location services in iOS 11+, your Info.plist must provide a value for \(key).")
            }
        }
        else {
            let keyOnlyAlways = LocationAuthorizationLevelPlistKey.onlyAlways.rawValue
            let hasOnlyAlwaysKey = bundle.hasInfoPlistValue(forKey: keyOnlyAlways)

            let keyAlwaysAndInUse = LocationAuthorizationLevelPlistKey.alwaysAndWhenInUse.rawValue
            let hasAlwaysAndInUseKey = bundle.hasInfoPlistValue(forKey: keyAlwaysAndInUse)

            let hasAlwaysKey: Bool = hasOnlyAlwaysKey && hasAlwaysAndInUseKey

            let keyOnlyInUse = LocationAuthorizationLevelPlistKey.alwaysAndWhenInUse.rawValue
            let hasOnlyInUseKey = bundle.hasInfoPlistValue(forKey: keyOnlyInUse)

            if hasAlwaysKey {
                level = .always
            }
            else if hasOnlyInUseKey {
                level = .whenInUse
            }
            else {
                // At least one of the keys NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription MUST
                // be present in the Info.plist file to use location services on iOS 8+.
                fatalError("To use location services in iOS 8+, your Info.plist must provide a value for either \(keyOnlyInUse) or \(hasOnlyAlwaysKey).")
            }

        }

        return level
    }


//    /// Check if application's Info.plist key has valid values for privacy settings for the required authorization level
//    ///
//    /// - Parameter level: level you want to set
//    /// - Returns: `true` if valid
//    public static func validateInfoPlistRequiredKeys(forLevel level: AuthorizationLevel) -> Bool {
//        let osVersion = (UIDevice.current.systemVersion as NSString).floatValue
//        switch level {
//        case .always:
//            if osVersion < 11 {
//                return     (hasPlistValue(forKey: "NSLocationAlwaysUsageDescription") ||
//                    hasPlistValue(forKey: "NSLocationAlwaysAndWhenInUseUsageDescription"))
//
//            }
//            return hasPlistValue(forKey: "NSLocationAlwaysAndWhenInUseUsageDescription")
//        case .whenInUse:
//            if osVersion < 11 { return hasPlistValue(forKey: "NSLocationWhenInUseUsageDescription") }
//            return hasPlistValue(forKey: "NSLocationAlwaysAndWhenInUseUsageDescription")
//        }
//    }
    
//    /// Current state of the authorization service
//    public var serviceAuthorizationStatus: LocationServiceAuthorizationStatus {
//        guard CLLocationManager.locationServicesEnabled() else { return .disabled }
//        
//        var status: LocationServiceAuthorizationStatus
//        switch CLLocationManager.authorizationStatus() {
//        case .notDetermined: status = .notDetermined
//        case .denied: status = .denied
//        case .restricted: status = .restricted
//        case .authorizedAlways: status = .authorized(level: .always)
//        case .authorizedWhenInUse: status = .authorized(level: .whenInUse)
//        }
//
//        return status
//    }


    /// Are services authorization
    public var isLocationServiceEnabled: Bool {
        return CLLocationManager.locationServicesEnabled()
    }

    var authorizationStatus: CLAuthorizationStatus {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        return authorizationStatus
    }

    public var isAuthorized: Bool {
        guard CLLocationManager.locationServicesEnabled() else { return false }

        let authorizationStatus = CLLocationManager.authorizationStatus()
        var isAuthorized: Bool = true
        switch authorizationStatus {
            case .notDetermined, .denied, .restricted: isAuthorized = false
            case .authorizedAlways, .authorizedWhenInUse: isAuthorized = true
        }

        return isAuthorized
    }

}
