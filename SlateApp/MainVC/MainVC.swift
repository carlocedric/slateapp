//
//  MainVC.swift
//  SlateApp
//
//  Created by admin on 2/23/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import CoreLocation
import Reachability
import SystemConfiguration.CaptiveNetwork


class MainVC: UIViewController {
    
    var currentLatitude:CLLocationDegrees?
    var currentLongitude:CLLocationDegrees?
    var distance:Double?
    @IBOutlet weak var lblLatitude:UILabel!
    @IBOutlet weak var lblLongitude:UILabel!
    @IBOutlet weak var lblDistance:UILabel!
    @IBOutlet weak var lblNetwork:UILabel!
    @IBOutlet weak var lblStatus:UILabel!
    @IBOutlet weak var lblLatitudeMain:UILabel!
    @IBOutlet weak var lblLongitudeMain:UILabel!
    @IBOutlet weak var viewStatus:UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //initialize the location manager
        LocationManager.sharedInstance.initLocation()
        LocationManager.sharedInstance.locationManagerDelegate = self
        
        //initialize the network manager
        NetworkManager.sharedInstance.setupReachability()
        
        //add observer for network/wifi changes
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: nil)
        
    }
    
    //Method to set the Main / Target Location
    @IBAction func didSetLocation(){
        guard let long = currentLongitude, let lat = currentLatitude else { return }
        
        UserPreferencesManager.sharedInstance.mainLocation = CLLocation(latitude: lat, longitude: long)
        UserPreferencesManager.sharedInstance.mainLatitude = lat
        UserPreferencesManager.sharedInstance.mainLongitude = long
        
    }
    
    //Method to clear the Main / Target Location
    @IBAction func didClearLocation(){
        UserPreferencesManager.sharedInstance.mainLocation = nil
        UserPreferencesManager.sharedInstance.mainLatitude = nil
        UserPreferencesManager.sharedInstance.mainLongitude = nil
    }
    
    //Method to handle network / wifi changes
    @objc func reachabilityChanged(note: Notification) {
        
        if let reachability = note.object as? Reachability{
            switch reachability.connection {
            case .wifi:
                lblNetwork.text = "Reachable via WiFi"
                NetworkManager.sharedInstance.reachabilityStatus = .wifi
            case .cellular:
                lblNetwork.text = "Reachable via Cellular"
                NetworkManager.sharedInstance.reachabilityStatus = .cellular
                print("Reachable via Cellular")
            case .none:
                lblNetwork.text = "Network not reachable"
                NetworkManager.sharedInstance.reachabilityStatus = .none
                print("Network not reachable")
            }
        }

    }
    
    //Method to determine if the current location & network setting is within or outside bounds
    func getDistanceStatus(){
        
        guard UserPreferencesManager.sharedInstance.mainLocation != nil else {
            lblStatus.text = "INSIDE | "
            viewStatus.backgroundColor = Constants.Colors.withinRadius
            return
        }
        
        if (NetworkManager.sharedInstance.reachabilityStatus == .wifi){
            viewStatus.backgroundColor = Constants.Colors.withinRadius
            lblStatus.text = "INSIDE | "
            return
        }
        
        if let tempDistance = distance{
            if tempDistance < Constants.Developer.maxDistance{
                viewStatus.backgroundColor = Constants.Colors.withinRadius
                lblStatus.text = "INSIDE | "
            }
            else{
                viewStatus.backgroundColor = Constants.Colors.outOfRadius
                lblStatus.text = "OUTSIDE | "
            }
        }else{
             viewStatus.backgroundColor = Constants.Colors.withinRadius
            lblStatus.text = "INSIDE | "
        }

    }
   

}


extension MainVC: LocationManagerDelegate {
    
    //Alert to request user permission to allow app to use location
    func showRequestLocation() {
        let alertController = UIAlertController(title: "Background Location Access Disabled",
                                                message: "In order to know the distance, we need your location",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)

    }
    
    //handler to update UI elements on location changes
    func didUpdateLocation(location: CLLocation) {
        
        currentLongitude = location.coordinate.longitude
        currentLatitude = location.coordinate.latitude
        
        lblLatitude.text = String(format: "%2f", location.coordinate.latitude)
        lblLongitude.text = String(format: "%2f", location.coordinate.longitude)
        
        if let mainLoc = UserPreferencesManager.sharedInstance.mainLocation{
             distance = mainLoc.distance(from: location)
            lblDistance.text = String(format: "%.2f meters", distance ?? 0.0)
        }
        else{
            lblDistance.text = "0 meters"
            lblLatitudeMain.text = lblLatitude.text
            lblLongitudeMain.text = lblLongitude.text
        }
        
        self.getDistanceStatus()
     
       

    }
    
  
}
