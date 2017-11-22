//
//  LocationServiceAuthorizationStatus.swift
//  LocationService
//
//  Created by Maksym Prokopchuk on 11/22/17.
//  Copyright © 2017 LocationService. All rights reserved.
//

import Foundation

/// The possible states that location services can be in.
///
/// - available: User has already granted this app permissions to access location services, and they are enabled and ready for use by this app. Note: this state will be returned for both the "When In Use" and "Always" permission levels
/// - notDetermined: User has not yet responded to the dialog that grants this app permission to access location services.
/// - denied: User has explicitly denied this app permission to access location services. (The user can enable permissions again for this app from the system Settings app.)
/// - restricted: User does not have ability to enable location services (e.g. parental controls, corporate policy, etc).
/// - disabled: User has turned off location services device-wide (for all apps) from the system Settings app.
public enum LocationServiceAuthorizationStatus {
    case authorized(level: LocationAuthorizationLevel)
    case notDetermined
    case denied
    case restricted
    case disabled
}
