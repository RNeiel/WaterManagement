//
//  WaterLocnDetails.swift
//  WaterManagement
//
//  Created by IE3PMDP000046 on 29/06/16.
//  Copyright © 2016 Honeywell. All rights reserved.
//

import Foundation


class WaterLocnDetails
{
    var locID: Int
    var locLong:String
    var locLat:String
    var locHealth:Int
    var locName:String
    
    init(locID:Int, locLong:String, locLat:String, locHealth:Int, locName:String)
    {
        self.locID = locID
        self.locLong = locLong
        self.locLat = locLat
        self.locHealth = locHealth
        self.locName = locName
    }
    
}