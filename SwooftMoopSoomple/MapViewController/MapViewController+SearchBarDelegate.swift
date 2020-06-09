//
//  MapViewController+SearchBarDelegate.swift
//  Created 6/9/20
//  Using Swift 5.0
// 
//  Copyright © 2020 K Y. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import UIKit
import MapKit

extension MapViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let loc = Geocoder()
        let c = mapView.userLocation.coordinate
        
        let r = MKCoordinateRegion(center: c, span: mapView.region.span)
        if #available(iOS 13.0, *) {
            loc.find(searchBar.text!, region: r)
        } else {
            loc.find2(searchBar.text!, region: r)
            return
        }
        
        // Fallback on earlier versions
        let reg = CLCircularRegion(center: c,
                                   radius: 100,
                                   identifier: "current region")
        loc.find(searchBar.text!, region: reg)
        
    }
}

