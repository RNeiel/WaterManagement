//
//  FirstViewController.swift
//  WaterManagement
//
//  Created by IE3PMDP000046 on 27/06/16.
//  Copyright © 2016 Honeywell. All rights reserved.
//

import UIKit
import MapKit
import Charts
import Alamofire



class FirstViewController: UIViewController,MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var allBtn: UIButton!
    @IBOutlet weak var DetailsBtn: UIButton!
    @IBOutlet weak var LocationDetails: UIView!
    @IBOutlet weak var demSupply: BarChartView!
    
    
    var locationArray = [WaterLocnDetails]()
    
    let GLocation = Location.sharedInstance
    
    var selectedLocn = CLLocationCoordinate2D()
    
    @IBAction func DetailsBtn(sender: AnyObject) {
        
        let Hydet = MKCoordinateRegionMake(selectedLocn,MKCoordinateSpanMake(0.05, 0.05))
        
        mapView.setRegion(Hydet , animated: true)
        
        addRoute()
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        DetailsBtn.hidden = true
        LocationDetails.hidden = true
        demSupply.hidden = true
        
        
        mapView.delegate = self
        
        readLocations()
        
        let Hydet = MKCoordinateRegionMake(CLLocationCoordinate2DMake(17.409031,78.481030),MKCoordinateSpanMake(0.45, 0.45))
    
        
        
        mapView.setRegion(Hydet , animated: true)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "MyPin"
        
        if annotation.isKindOfClass(MKUserLocation) {
            return nil
        }
        
        
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
        if  annotationView == nil  {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            
            annotationView!.image = UIImage(named: "pingreen.pdf")
            
            annotationView?.setSelected(false, animated: false)
            
        }
        else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        
        let overlays = mapView.overlays
        if(overlays.count != 0){
            mapView.removeOverlays(overlays)}
        
        
        if view.annotation == nil{
            
            DetailsBtn.hidden = true
            LocationDetails.hidden = true
            demSupply.hidden = true
            
            
        }
        
        if !(view.annotation!.isKindOfClass(MKUserLocation)) {
            
            var Selectedannotation = CLLocationCoordinate2D()
            Selectedannotation = (view.annotation?.coordinate)!
            
            selectedLocn = Selectedannotation
            
            self.GLocation.Position = selectedLocn
            
            DetailsBtn.hidden = false
            LocationDetails.hidden = false
            demSupply.hidden = false
            
            mapView.addOverlay(MKCircle(centerCoordinate: Selectedannotation, radius: 1000))
            // mapView.addOverlay(<#T##overlay: MKOverlay##MKOverlay#>)
            
            print(Selectedannotation)
        }
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer! {
        if overlay is MKCircle{
            let circleRenderer = MKCircleRenderer(overlay: overlay)
            circleRenderer.fillColor = UIColor(red: 1, green: 165/255, blue: 0, alpha: 0.2)
            return circleRenderer
        }
        
        if overlay is MKPolyline {
            let lineView = MKPolylineRenderer(overlay: overlay)
            lineView.strokeColor = UIColor.greenColor()
            
            return lineView
        }
        
        return nil
    }
    
    func addRoute() {
        let thePath = NSBundle.mainBundle().pathForResource("EntranceToGoliathRoute", ofType: "plist")
        let pointsArray = NSArray(contentsOfFile: thePath!)
        
        let pointsCount = pointsArray!.count
        
        var pointsToUse: [CLLocationCoordinate2D] = []
        
        for i in 0...pointsCount-1 {
            let p = CGPointFromString(pointsArray![i] as! String)
            pointsToUse += [CLLocationCoordinate2DMake(CLLocationDegrees(p.x), CLLocationDegrees(p.y))]
        }
        
        let myPolyline = MKPolyline(coordinates: &pointsToUse, count: pointsCount)
        
        mapView.addOverlay(myPolyline)
    }
    
    func readLocations()
    {
        print("trying to get json")
        
        
        Alamofire.request(.GET, "https://honwaterserviceapi.azurewebsites.net/api/Location", parameters: ["foo" : "bar"]) .responseJSON { response in
    
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            
                let id = JSON[0]["LocName"]
                print(id)
                let id2 = JSON[1]["LocName"]
                print(id2)
                
                
                for index in JSON as! [AnyObject]{
                    
                    guard let id = index["LocId"] as? Int
                    else
                    {
                    return}
                    
                    guard let latitude = index["LocLat"] as? String
                        else
                    {
                        return}
                    
                    guard let longitude = index["LocLong"] as? String
                        else
                    {
                        return}
                    
                    guard let health = index["LocHealth"] as? Int
                        else
                    {
                        return}
                    
                    guard let name = index["LocName"] as? String
                        else
                    {
                        return}
                    

                    
                    print(id)

                    let loc = WaterLocnDetails(locID: id,locLong: latitude,locLat: longitude,locHealth: health,locName: name)
                    self.locationArray.append(loc)
        
                    
                }
                
                print(self.locationArray.count)
                
                var locationsArr = [CLLocationCoordinate2D]()
                
                for Locn in self.locationArray{
                    print("appending")
                    print( Double(Locn.locLat)!)
                    print( Double(Locn.locLong)!)
                    
                    locationsArr.append(CLLocationCoordinate2D(latitude: Double(Locn.locLong)!, longitude: Double(Locn.locLat)!))
                    
                }
                
                
                locationsArr.append(CLLocationCoordinate2D(latitude: 17.427252, longitude: 78.342873))
                locationsArr.append(CLLocationCoordinate2D(latitude: 17.435507, longitude: 78.334345))
                locationsArr.append(CLLocationCoordinate2D(latitude: 17.446320, longitude: 78.355400))
                locationsArr.append(CLLocationCoordinate2D(latitude: 17.485407, longitude: 78.315660))
                
                for index in locationsArr
                {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = index
                    annotation.title = "a"
                    self.mapView.addAnnotation(annotation)
                }

                
                
                
            }

            
            
        }

}

}