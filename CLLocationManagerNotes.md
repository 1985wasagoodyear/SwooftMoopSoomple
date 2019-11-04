#  CLLocationManager Notes

CLLocationManager is an object that 
1. Represents the GPS device on your device.
    * as such, no-more than 1 instance should be instantiated
2. Works to obtain location changes
3. Works with user permissions for location-tracking

Remark that CLLocationManager does not require a map to function. It can perfectly track or receive a user's location information without explicitly displaying it to the user. 

This can be useful for determining the user's current address, assisting to locate a nearby location/store, etc.


## Setup:

CLLocationManager has two properties to remark:

`desiredAccuracy` - the desired accuracy of location changes, meters
`distanceFilter` - a minimum distance threshold before an update is reported, meters

In addition, there are two large properties to call before asking to `startUpdatingLocation`:

`requestAlwaysAuthorization` -  use this to always receive location changes, in foreground and background states
`requestWhenInUseAuthorization` - use this only for foreground state changes

*Remark:* Any authorization requested must have the appropriate Privacy key setup within the `Info.plist` of your application before installation.

## CLLocationManagerDelegate:

CLLocationManager is set up with a delegation pattern. An object conforming to this delegate can, among other things:

* Determine and act upon authorization changes
* Receive location changes
* Track users entering/leaving pre-determined regions
* Handle errors on GPS tracking


## CLRegion

A defined region that a user can enter/leave. 

A region can represent any number of things, the bounds of some property, location of a store, etc.

Regions can be tracked but rendering them is another responsibility (usually a map).

Also of remark: by design, an application may only monitor 20 regions at any given time.


##  A Concern:

Because of the nature of GPS, exercise caution in determining the nature of your CLLocationManager within your application.

GPS can be a battery-intensive-task to work with. 

Smart applications modify the 
* accuracy, 
* distance-filter, 
* enable/disable location updates, 
* etc, 
during runtime, according to the individual business logic that is applicable for the individual app.
