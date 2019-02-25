//
//  Constants.swift
//  SlateApp
//
//  Created by admin on 2/23/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

//Set all constants here
struct Constants {
    
    struct Developer {
        //Set the max distance to consider whether user is within or outside bounds
        static let maxDistance = 10.0
    }
    
    struct Colors {
        static let withinRadius = UIColor(red: 46.0/255.0, green: 204.0/255.0, blue: 113.0/255.0, alpha: 1.0)
        static let outOfRadius = UIColor(red: 255.0/255.0, green: 108.0/255.0, blue: 92.0/255.0, alpha: 1.0)
    }
    
}

