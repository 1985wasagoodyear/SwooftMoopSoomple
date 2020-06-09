//
//  MapViewController+CLLocationManager.swift
//  SwooftMoopSoomple
//
//  Created by K Y on 11/3/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import CoreLocation

extension MapViewController: CLLocationManagerDelegate {
    
    /// when the user authorization changes, begin location updates or show some appropriate error
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            fallthrough
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .denied:
            showSettingsAlert(text: "Location Services Denied.",
                              subtext: "Please enable location services in Settings.")
        case .notDetermined:
            fallthrough
        case .restricted:
            fallthrough
        @unknown default:
            print("Error - was unable to determine user location")
        }
    }
    
    /// this is CLLocationManager's main means of relaying location updates to your app
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.first else { return }
        
        // re-center the map when the user moves
        centerMap(on: loc)
        
        // if we haven't already, make a target location for the user
        if targetRegion == nil {
            createRegion(from: loc, direction: .random, miles: 0.3)
        }
    }
    
    /// handles user's entry into a region
    func locationManager(_ manager: CLLocationManager,
                         didEnterRegion region: CLRegion) {
        if region === targetRegion {
            showAlert(text: "Did enter region!")
        }
    }
    
    /// handles user's exit from the region
    func locationManager(_ manager: CLLocationManager,
                         didExitRegion region: CLRegion) {
        if region === targetRegion {
            showAlert(text: "Did leave region!")
        }
    }
    
}
