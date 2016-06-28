//
//  Location.swift
//  WaterManagement
//
//  Created by IE3PMDP000046 on 28/06/16.
//  Copyright © 2016 Honeywell. All rights reserved.
//

import Foundation
import MapKit

class Location {
    class var sharedInstance: Location {
        struct Static {
            static var instance: Location?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = Location()
        }
        
        return Static.instance!
    }
    
    var userId: Int = 0
    var name: String = ""
    var Position = CLLocationCoordinate2D()
}
