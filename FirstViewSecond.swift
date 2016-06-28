//
//  FirstViewSecond.swift
//  WaterManagement
//
//  Created by IE3PMDP000046 on 28/06/16.
//  Copyright © 2016 Honeywell. All rights reserved.
//

import UIKit
import MapKit

class FirstViewSecond: UIViewController {

   // @IBOutlet weak var mapView2: MKMapView!
    
    @IBOutlet weak var mapView2: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let GLocation = Location.sharedInstance
        
       // mapView.delegate = self
       
        print ("I am in second")
        print( GLocation )
        
        
        let Hydet = MKCoordinateRegionMake(GLocation.Position,MKCoordinateSpanMake(0.05, 0.05))
        
        
        mapView2.setRegion(Hydet , animated: true)

        
        
       }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
