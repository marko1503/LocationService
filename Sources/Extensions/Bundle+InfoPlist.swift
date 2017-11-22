//
//  Bundle+InfoPlist.swift
//  LocationService
//
//  Created by Maksym Prokopchuk on 11/22/17.
//  Copyright © 2017 LocationService. All rights reserved.
//

import Foundation

public extension Bundle {

    /// Return is specified value is set in Info.plist of the host application
    ///
    /// - Parameter key: key to validate
    /// - Returns: `true` if exists
    public func hasInfoPlistValue(forKey key: String) -> Bool {
        guard let dict = self.infoDictionary else { return false }
        guard let value = dict[key] as? String else { return false }
        guard value.isEmpty == false else { return false }
        return true
    }

}
