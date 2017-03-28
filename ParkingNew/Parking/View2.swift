//
//  View2.swift
//  Parking
//
//  Created by Randy Lina on 1/5/17.
//  Copyright © 2017 Ralph Lina. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class View2 : UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    var previousAddress: String!
    
    
    func backColor() {
        //self.view.backgroundColor = UIColor.grayColor()
        self.view.backgroundColor = UIColor(red: (255/255)*2, green: (247/255)*2, blue: (227/255)*2, alpha: 0.5)
    }
    
    @IBOutlet weak var helloname: UILabel!
    

    
    var labelText = String()
    
    
    override func viewDidLoad() {
        /*
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        */
        
        backColor()
        helloname.text = labelText

    }
    /*
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location: CLLocation = locations.first!
        self.mapView.centerCoordinate = location.coordinate
        let reg = MKCoordinateRegionMakeWithDistance(location.coordinate, 1500, 1500)
        self.mapView.setRegion(reg, animated: true)
        //geoCode(location)
        // 3:53 FROM THE TUTORIAL, stopped there
        
    }
    */
    
}
