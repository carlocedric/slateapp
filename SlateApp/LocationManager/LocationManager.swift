//
//  LocationManager.swift
//  SlateApp
//
//  Created by admin on 2/24/19.
//  Copyright © 2019 admin. All rights reserved.
//


import Foundation
import CoreLocation

protocol LocationManagerDelegate {
    func didUpdateLocation(location:CLLocation)
    func showRequestLocation()
}

class LocationManager : NSObject, CLLocationManagerDelegate{
    static let sharedInstance = LocationManager()
    var locationManager = CLLocationManager()
    var locationManagerDelegate:LocationManagerDelegate?
    
    var long:CLLocationDegrees?
    var lat:CLLocationDegrees?
    
    //Initialize Location setup
    func initLocation(){
        // For use when the app is open & in the background
        locationManager.requestAlwaysAuthorization()
        
        // If location services is enabled get the users location
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            // Set as the most accurate location setting
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.startUpdatingLocation()
        }
    }
    
    //Track user location changes
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManagerDelegate?.didUpdateLocation(location: location)
        }
    }
    
    // If we have been deined access give the user the option to change it
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            //call the delegate's view controller to present the request form.
            locationManagerDelegate?.showRequestLocation()
        }
    }
    

    
}
