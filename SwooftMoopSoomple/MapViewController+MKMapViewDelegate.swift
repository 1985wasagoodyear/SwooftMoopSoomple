//
//  MapViewController+MKMapViewDelegate.swift
//  SwooftMoopSoomple
//
//  Created by K Y on 11/3/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import MapKit

private let PIN_ANNOTATION_REUSE_ID = "MKPinAnnotationView"

extension MapViewController: MKMapViewDelegate {
    /// show some MKAnnotationView for each annotation
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // is this the default annotation for the user's location?
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        // otherwise, customize some other pin
        let pin = MKPinAnnotationView(annotation: annotation,
                                   reuseIdentifier: PIN_ANNOTATION_REUSE_ID)
        pin.canShowCallout = true
        /// this button could have a custom target
        pin.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return pin;
    }
    
    /// called if a callout is tapped.
    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        if view.annotation === targetAnnotation {
            print("Did tap callout")
        }
    }
    
    /// called if selection is tapped
    func mapView(_ mapView: MKMapView,
                 didSelect view: MKAnnotationView) {
        if view.annotation === targetAnnotation {
            print("did select annotation")
        }
    }
    
    /// called if selection is untapped
    func mapView(_ mapView: MKMapView,
                 didDeselect view: MKAnnotationView) {
        if view.annotation === targetAnnotation {
            print("did deselect annotation")
        }
    }

    /// render an MKOverlay for each Overlay
    func mapView(_ mapView: MKMapView,
                 rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        // is this a circular region and the one we're tracking?
        if overlay is MKCircle && overlay === targetOverlay {
            return .blueRenderer(overlay: overlay)
        }
        // otherwise, make some other renderer
        return MKOverlayRenderer(overlay: overlay)
    }
    
}

