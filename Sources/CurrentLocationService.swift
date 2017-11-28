//
//  LocationRequest.swift
//  LocationService
//
//  Created by Maksym Prokopchuk on 11/22/17.
//  Copyright © 2017 LocationService. All rights reserved.
//

import Foundation
import CoreLocation

public class CurrentLocationService: LocationService {

    public private(set) var currentLocation: CLLocation?

    public private(set) var currentLocationHandler: CurrentUserLocationHandler?

    public typealias CurrentUserLocationHandler = (_ location: CLLocation) -> ()
    public func currentLocation(complition: @escaping CurrentUserLocationHandler) {
        self.currentLocationHandler = complition
        self.startUpdatingLocation()
    }

    public func resetCurrentLocation() {
        self.currentLocation = nil
    }

}

// MARK: - CLLocationManagerDelegate
extension CurrentLocationService {

    private func p_processUpdateLocations(locations: [CLLocation]) {
        guard self.currentLocation == nil else { return }

        let recentLocation: CLLocation? = locations.max { (a, b) -> Bool in
            return a.timestamp > b.timestamp
        }

        guard let currentLocation = recentLocation else { return }
        print("LocationService: \(currentLocation)")
        guard let handler = self.currentLocationHandler else { return }
        self.currentLocation = currentLocation
        handler(currentLocation)
        self.stopUpdatingLocation()
    }

    // MARK: -
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.p_processUpdateLocations(locations: locations)
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.stopUpdatingLocation()
    }

}


