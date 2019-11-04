#  MKMapView

Apple's first-party view for displaying map information.


## Setup:

There are a multitude of different options for map-renders, showing/hiding current user location, etc.

The current user location must be polled for via an instance of CLLocationManager. Doing so will implicitly relay the user's current location to the map.

MKMapView is also built upon a delegate pattern, via `MKMapViewDelegate`. An object conforming to this property can 


## Annotations

Annotations are individual locations upon a map, which can be represented by a pin, an image, etc. They can be selected/deselected, present different information, show different views, etc.

Of note, there exists:
* `MKAnnotation` - a protocol for all annotations
* `MKPointAnnotation` - a base class of an annotation
* `MKAnnotationView` -  a base class for a view for an annotation

For views, MapKit follows the same rules as UITableView and UICollectionView-they enqueue and dequeue reusable pins.

 
## Overlays

These can be used to represent regions. They require to be rendered by a distinct UIView type, an `MKOverlayRenderer`.

Of note, there exists:
* `MKOverlay` - a protocol for all overlays
* `MKCircle` - a circular overlay.

These are determined for use within the MKMapViewDelegate adopter.
