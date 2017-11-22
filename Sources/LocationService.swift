//
//  LocationService.swift
//  LocationService
//
//  Created by Maksym Prokopchuk on 11/22/17.
//  Copyright © 2017 LocationService. All rights reserved.
//

import Foundation
import CoreLocation

//protocol LocationManager {
//
//    func requestAlwaysAuthorization()
//
//    func requestWhenInUseAuthorization()
//
//}

public class LocationService: NSObject {

    // MARK: - Dependencies
    public let locationManager: CLLocationManager

    // MARK: - Authroziation
    public typealias LocationAuthorizationStatusChanged = (_ status: CLAuthorizationStatus) -> ()
    public var authorizationStatusChanged: LocationAuthorizationStatusChanged?

    // MARK: -
    /// Returns the current state of location services for this app,
    /// based on the system settings and user authorization status.
    public var authorizationStatus: CLAuthorizationStatus {
        let authorizationStatus = self.locationManager.authorizationStatus
        return authorizationStatus
    }

    // MARK: - Init
    public init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()
        
        self.locationManager.delegate = self
    }

    // MARK: -
    /// Validate and request authorization level
    ///
    /// - Parameter level: level to require
    public func requestAuthorization(level: LocationAuthorizationLevel) {
        // Validate the level you want to set before doing a request
//        if CLLocationManager.validateInfoPlistRequiredKeys(forLevel: level) == false {
//            fatalError("Missing Info.plist entries for required authorization level")
//        }

        switch level {
            case .always:
                self.locationManager.requestAlwaysAuthorization()
            case .whenInUse:
                self.locationManager.requestWhenInUseAuthorization()
        }
    }

    internal func startUpdatingLocation() {
        self.locationManager.startUpdatingLocation()
    }

    internal func stopUpdatingLocation() {
        self.locationManager.stopUpdatingLocation()
    }
    
}

// MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {

    // MARK: -
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard let authorizationStatusChanged = self.authorizationStatusChanged else { return }
        authorizationStatusChanged(status)
    }

}
