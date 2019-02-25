//
//  UserPreferencesManager.swift
//  SlateApp
//
//  Created by admin on 2/24/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import CoreLocation

//Store User Preferences

class UserPreferencesManager: NSObject {
    static let sharedInstance = UserPreferencesManager()
    
    //Global variables to get/set the desired "main/target location" coordinates
    var mainLocation:CLLocation?
    var mainLatitude:Double?
    var mainLongitude:Double?
}
