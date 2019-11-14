//
//  MapViewController.swift
//  SwooftMoopSoomple
//
//  Created by K Y on 11/3/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit
import MapKit


/*********************************************
 Map Constants
 
 Inject these however you please within your business logic,
 or leave hard-coded for use.
 
 * MAP_SPAN_MILES                 - 'diameter' of the map shown
 * REGION_RADIUS_METERS  - diameter of the target region user must walk to
 * TARGET_REGION_ID             - identifier string for target region
 *********************************************/
private let MAP_SPAN_MILES = 1.0
private let REGION_RADIUS_METERS = 30.0
private let TARGET_REGION_ID = "targetRegionIdentifier"
private let PIN_ANNOTATION_REUSE_ID = "MKPinAnnotationView"

final class MapViewController: UIViewController {
    
    // MARK: - View Properties
    
    lazy var mapView: MKMapView = {
        let mView = MKMapView(frame: .zero)
        mView.delegate = self
        mView.showsUserLocation = true
        mView.register(MKPinAnnotationView.self,
                       forAnnotationViewWithReuseIdentifier: PIN_ANNOTATION_REUSE_ID)
        return mView
    }()
    
    lazy var searchBar: UISearchBar = {
        let sBar = UISearchBar(frame: .zero)
        sBar.delegate = self
        return sBar
    }()
    
    // MARK: - Location Properties
    lazy var manager: CLLocationManager = {
        let m = CLLocationManager()
        m.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        m.distanceFilter = 5.0 // meters
        return m
    }()
    
    /// tracks a current location of interest
    var targetRegion: CLCircularRegion!
    /// tracks current overlay for rendering a region
    /// remark: MKCircle is a subclass of MKOverlay
    var targetOverlay: MKCircle!
    /// tracks a current annotation for a location, of interest
    var targetAnnotation: MKPointAnnotation!

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getLocationUpdates()
    }
    
    // MARK: - Setup Methods
    
    func setupView() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        let constraints = [
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        let constraints2 = [
            mapView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints + constraints2)
    }
    
    func getLocationUpdates() {
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
    }
    
    // MARK: - MapView Methods
    
    /// creates a region, annotation, and overlay for a target
    func createRegion(from loc: CLLocation,
                      direction: CardinalDirection,
                      miles: Double) {
        // determine the coordinates for the target
        let coord = loc.coordinate.locationDelta(in: direction,
                                                 miles: miles)
        
        // build a region and start tracking our location wrt it
        let region = CLCircularRegion(center: coord,
                                      radius: REGION_RADIUS_METERS, identifier: TARGET_REGION_ID)
        region.notifyOnEntry = true
        region.notifyOnExit = true
        targetRegion = region
        manager.startMonitoring(for: region)
        
        // build an overlay to render a circle around the region
        let overlay = MKCircle(center: coord,
                               radius: REGION_RADIUS_METERS)
        targetOverlay = overlay
        mapView.addOverlay(overlay)
        
        // build an annotation to place an interactive pin atop it
        let annotation = MKPointAnnotation()
        annotation.title = "Target"
        annotation.subtitle = "This is your first objective"
        annotation.coordinate = coord
        targetAnnotation = annotation
        mapView.addAnnotation(annotation)
    }
    
    // center the map around our position, as we move
    func centerMap(on loc: CLLocation) {
        let latDelta = CLLocationDegrees.latitude(miles: MAP_SPAN_MILES)
        let lonDelta = CLLocationDegrees.longitude(miles: MAP_SPAN_MILES)
        let span = MKCoordinateSpan(latitudeDelta: latDelta,
                                    longitudeDelta: lonDelta)
        let region = MKCoordinateRegion(center: loc.coordinate,
                                        span: span)
        mapView.setRegion(region, animated: true)
    }
    
    // or, call this if we don't want to re-zoom the map
    func centerMapWithoutSpanChange(on loc: CLLocation) {
        mapView.setCenter(loc.coordinate,
                          animated: true)
    }
}
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
