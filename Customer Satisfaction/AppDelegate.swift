//
//  AppDelegate.swift
//  Heathrow Satisfaction
//
//  Created by Simon Cook on 05/08/2016.
//  Copyright © 2016 Salesforce. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
    
    var window: UIWindow?
    
    let virtualBeaconUUID: String = "8492E75F-4FD6-469D-B132-043FE94921D8"
    let virtualMajor: UInt16 = 6783
    let virtualMinor: UInt16 = 22264
    let purpleBeaconUUID: String  = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
    let purpleMajor: UInt16 = 12538
    let purpleMinor: UInt16 = 61339
    let blueBeaconUUID: String    = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
    let blueMajor: UInt16 = 50825
    let blueMinor: UInt16 = 27804
    let greenBeaconUUID: String   = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
    let greenMajor: UInt16 = 48074
    let greenMinor: UInt16 = 47114
    var locationManager: CLLocationManager = CLLocationManager()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        NSThread.sleepForTimeInterval(2);
        
        // create the location manager and set the delegate
        locationManager = CLLocationManager();
        locationManager.delegate = self;
        locationManager.requestAlwaysAuthorization()
        
        //remove any existing regions
        for monitored in locationManager.monitoredRegions {
            locationManager.stopMonitoringForRegion(monitored)
            print("removing beacons")
        }
        
        //create the beacon
        let uuid1 = NSUUID(UUIDString: virtualBeaconUUID);
        let region1 = CLBeaconRegion(proximityUUID: uuid1!, major: virtualMajor, minor: virtualMinor, identifier: "Parking Experience")
        region1.notifyEntryStateOnDisplay = true
        locationManager.startRangingBeaconsInRegion(region1)
        let uuid2 = NSUUID(UUIDString: purpleBeaconUUID);
        let region2 = CLBeaconRegion(proximityUUID: uuid2!, major: purpleMajor, minor: purpleMinor, identifier: "Check in Experience")
        region2.notifyEntryStateOnDisplay = true
        locationManager.startRangingBeaconsInRegion(region2)
        let uuid3 = NSUUID(UUIDString: blueBeaconUUID);
        let region3 = CLBeaconRegion(proximityUUID: uuid3!, major: blueMajor, minor: blueMinor, identifier: "Secuirty Experience")
        region3.notifyEntryStateOnDisplay = true
        locationManager.startRangingBeaconsInRegion(region3)
        let uuid4 = NSUUID(UUIDString: greenBeaconUUID);
        let region4 = CLBeaconRegion(proximityUUID: uuid4!, major: greenMajor, minor: greenMinor, identifier: "Shopping Experience")
        region4.notifyEntryStateOnDisplay = true
        locationManager.startRangingBeaconsInRegion(region4)
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("LOCATIONMANAGER: Entered region " + region.description);
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("LOCATIONMANAGER: Did fail with error " + error.description);
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("LOCATIONMANAGER: Exited region " + region.description);
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        let regionID = region.identifier;
        
        if(beacons.count > 0) {
            let beacon: CLBeacon = beacons.first!
            if(beacon.proximity == CLProximity.Immediate) {
                NSNotificationCenter.defaultCenter().postNotificationName("updateLocation", object: regionID)
            }
        }
    }
}

