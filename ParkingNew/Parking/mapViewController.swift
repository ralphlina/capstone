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
import Firebase

class mapViewController : UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var address: UILabel!
    
    //map
    @IBOutlet weak var mapView: MKMapView!
    //var labelText = String()
    var manager = CLLocationManager()
    //var previousAddress: String!
    //var selectedLocation: LocationModel?
    
    
    func displayMyAlertMessage(userMessage: String)
    {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated: true, completion: nil);
    }
    
    func rideInProgress()
    {
        let ref = FIRDatabase.database().reference(fromURL: "https://ci-hitchhike-b028e.firebaseio.com/")
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        
        ref.child("messages").observe(FIRDataEventType.value, with: { snapshot in
            
            for child in (snapshot.value as? [String: AnyObject])!
            {
                ref.child("messages").child(child.key).observeSingleEvent(of: FIRDataEventType.value, with: { snap in
                    
                    let dict = (snap.value as? [String: AnyObject])!
                    if let userId = dict["UserId"] as? String
                    {
                        if uid! == userId
                        {
                            print("It worked I think.")
                            self.displayMyAlertMessage(userMessage: "Driver has accepted the request and is on the way.")
                        }
                        else
                        {
                            print("Wasn't the correct userId.")
                        }
                    }
                    else
                    {
                        print("UserId didn't work.")
                    }
                    
                })
            }
            
        })
        
        //        self.displayMyAlertMessage(userMessage: "Driver has accepted the request and is on the way.")
    }
    
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(rideInProgress), name: NSNotification.Name(rawValue: "ride in progress"), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
