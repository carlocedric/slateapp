//
//  NetworkManager.swift
//  SlateApp
//
//  Created by admin on 2/24/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import Reachability
import SystemConfiguration.CaptiveNetwork

class NetworkManager: NSObject {
    
    static let sharedInstance = NetworkManager()
    
    let reachability = Reachability()!
    var reachabilityStatus:Reachability.Connection?
   
    //Get WIFI / SSID name the device is currently connected
    func fetchSSIDInfo() ->  String {
        var currentSSID = ""
        if let interfaces:CFArray = CNCopySupportedInterfaces() {
            for i in 0..<CFArrayGetCount(interfaces){
                let interfaceName: UnsafeRawPointer = CFArrayGetValueAtIndex(interfaces, i)
                let rec = unsafeBitCast(interfaceName, to: AnyObject.self)
                let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(rec)" as CFString)
                if unsafeInterfaceData != nil {
                    
                    let interfaceData = unsafeInterfaceData! as Dictionary!
                    currentSSID = ((interfaceData as? [String : AnyObject])?["SSID"])! as! String
                    
                }
            }
        }
        return currentSSID
    }
    
    func setupReachability(){
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }

}



