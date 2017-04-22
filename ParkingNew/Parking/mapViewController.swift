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

class mapViewController : UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var address: UILabel!
    
    //map
    @IBOutlet weak var mapView: MKMapView!
    //var labelText = String()
    var manager = CLLocationManager()
    //var previousAddress: String!
    //var selectedLocation: LocationModel?
    
    @IBAction func backBtnTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        mapView.setRegion(region, animated: true)
        
        self.mapView.showsUserLocation = true
       
        
    }
    
    
    func backColor() {
        //self.view.backgroundColor = UIColor.grayColor()
        self.view.backgroundColor = UIColor(red: (255/255)*2, green: (247/255)*2, blue: (227/255)*2, alpha: 0.5)
    }
    
    
    override func viewDidLoad() {
        /*
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        */
        

        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        backColor()
        //helloname.text = labelText
        address.text = "CSU Channel Islands"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
}
