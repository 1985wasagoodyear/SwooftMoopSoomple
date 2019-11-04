//
//  MapViewController.swift
//  SwooftMoopSoomple
//
//  Created by K Y on 11/3/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit
import MapKit

enum Direction: CaseIterable {
    case east, south, west, north
    static var random: Direction {
        let allCases = Direction.allCases
        let i = Int.random(in: 0..<allCases.count)
        return allCases[i]
    }
}

private let MAP_SPAN_MILES = 1.0
private let REGION_RADIUS_METERS = 30.0
private let TARGET_REGION_ID = "targetRegionIdentifier"

class MapViewController: UIViewController {
    
    lazy var manager: CLLocationManager = {
        let m = CLLocationManager()
        return m
    }()
    
    lazy var mapView: MKMapView = {
        let mView = MKMapView(frame: .zero)
        mView.delegate = self
        mView.showsUserLocation = true
        return mView
    }()
    
    var targetOverlay: MKCircle!
    var targetRegion: CLCircularRegion!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getLocationUpdates()
    }
    
    func setupView() {
        mapView.fillIn(view)
    }
    
    
    func getLocationUpdates() {
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
    }


}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        return MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle && overlay === targetOverlay {
            let circleRenderer = MKCircleRenderer(overlay: overlay)
            circleRenderer.lineWidth = 5.0
            circleRenderer.strokeColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
            circleRenderer.fillColor = circleRenderer.strokeColor!.withAlphaComponent(0.1)
            return circleRenderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        showAlert(text: "Did enter region!")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        showAlert(text: "Did leave region!")
    }
}


extension MapViewController: CLLocationManagerDelegate {
    
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
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.first else { return }
        
        centerMap(on: loc)
        if targetRegion == nil {
            createRegion(from: loc, direction: .random, miles: 1.0)
        }
    }
    
    func createRegion(from loc: CLLocation,
                      direction: Direction,
                      miles: Double) {
        let coord = loc.coordinate.locationDelta(in: direction,
                                                 miles: miles)
        let region = CLCircularRegion(center: coord,
                                      radius: REGION_RADIUS_METERS, identifier: TARGET_REGION_ID)
        targetRegion = region
        manager.startMonitoring(for: region)
        
        let overlay = MKCircle(center: coord,
                               radius: REGION_RADIUS_METERS)
        targetOverlay = overlay
        mapView.addOverlay(overlay)
    }
    
    func centerMap(on loc: CLLocation) {
        let latDelta = CLLocationDegrees.latitude(miles: MAP_SPAN_MILES)
        let lonDelta = CLLocationDegrees.longitude(miles: MAP_SPAN_MILES)
        let span = MKCoordinateSpan(latitudeDelta: latDelta,
                                    longitudeDelta: lonDelta)
        let region = MKCoordinateRegion(center: loc.coordinate,
                                        span: span)
        mapView.setRegion(region, animated: true)
    }
}
