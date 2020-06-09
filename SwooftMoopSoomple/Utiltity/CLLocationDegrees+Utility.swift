//
//  CLLocationDegrees+Utility.swift
//  SwooftMoopSoomple
//
//  Created by K Y on 11/3/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import CoreLocation

extension CLLocationDegrees {
    static func latitude(miles: Double) -> CLLocationDegrees {
        return miles / 69.0
    }
    static func longitude(miles: Double) -> CLLocationDegrees {
        return miles / 60.0
    }
}

extension CLLocationCoordinate2D {
    func locationDelta(in direction: CardinalDirection,
                       miles: Double) -> CLLocationCoordinate2D {
        var loc = self
        switch direction {
        case .east:
            loc.longitude += .longitude(miles: miles)
        case .south:
            loc.latitude -= .latitude(miles: miles)
        case .west:
            loc.longitude -= .longitude(miles: miles)
        case .north:
            loc.latitude += .latitude(miles: miles)
        }
        return loc
    }
    
}
