//
//  Geocoder.swift
//  SwooftMoopSoomple
//
//  Created by K Y on 11/14/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class Geocoder {

    init() {
        
    }
    
    func find(_ query: String) {
        let g = CLGeocoder()
        g.geocodeAddressString(query,
                               completionHandler: handle)
    }
    func find(_ query: String, region: CLRegion) {
        let g = CLGeocoder()
        g.geocodeAddressString(query, in: region,
                               completionHandler: handle)
    }
    
    @available(iOS 13.0, *)
    func find(_ query: String, region: MKCoordinateRegion) {
        let r = MKLocalSearch.Request(__naturalLanguageQuery: query,
                                      region: region)
        let search = MKLocalSearch(request: r)
        search.start { (response, err) in
            if let err = err { print(err); return }
            guard let r = response else { return }
            for item in r.mapItems {
                print("Name: \(item.name ?? "n/a"), Placemark: \(item.placemark)")
            }
        }
    
    }
    
    func find2(_ query: String, region: MKCoordinateRegion) {
        let r = MKLocalSearch.Request()
        r.naturalLanguageQuery = query
        r.region = region
        let search = MKLocalSearch(request: r)
        search.start { (response, err) in
            if let err = err { print(err); return }
            guard let r = response else { return }
            for item in r.mapItems {
                print("Name: \(item.name ?? "n/a"), Placemark: \(item.placemark)")
            }
        }
        
    }
    
    func handle(placemarks: [CLPlacemark]?, error: Error?) {
        if let err = error {
            print(err); return
        }
        guard let placemarks = placemarks else { return }
        print("did find \(placemarks.count)-many places:")
        for p in placemarks {
            print(p)
        }
    }
}
