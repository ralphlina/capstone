//
//  View4going.swift
//  Parking
//
//  Created by Randy Lina on 3/14/17.
//  Copyright © 2017 Ralph Lina. All rights reserved.
//

import UIKit
import Firebase

class destinationViewController: UIViewController {
    
    var segLabel = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //FIRApp.configure()
        startLabel.text = segLabel
        // Do any additional setup after loading the view.
    }
    
     var delegate: SendDataToDriverDelegate?
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    
    func displayMyAlertMessage(userMessage: String)
    {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated: true, completion: nil);
    }
    
    
    @IBAction func backBtnTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signOutBtnTap(_ sender: Any) {
        try! FIRAuth.auth()!.signOut()
        
//        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
//            if user == nil {
//                // user is signed in so don't do anything
//            } else {
//                //the user has now signed out so go to login view controller
//                // and remove this listener
//                
//                //self.displayMyAlertMessage(userMessage: "Signed out");
//                
//                UserDefaults.standard.setValue(nil, forKey: "uid")
//                
//                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as UIViewController
//                // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
//                
//                self.present(viewController, animated: false, completion: nil)
//                
//            }
//        }
        
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
        self.present(viewController, animated: false, completion: nil)
    }
    
    let locations1 = ["Library", "Student Union", "Gym", "A7", "A8", "A9", "A10", "El Dorado", "Aliso Hall", "Sierra Hall"]
    
    
    func numberOfComponentsInPickerView(_ pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return locations1[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return locations1.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        label1.text = locations1[row]
    }
    
    @IBAction func requestBtnTap(_ sender: Any) {
        
        let ref = FIRDatabase.database().reference(fromURL: "https://ci-hitchhike-b028e.firebaseio.com/")
        let uid = FIRAuth.auth()?.currentUser?.uid
        
        let userRideData = ref.child("UserRides").child(uid!).childByAutoId()
        
        //let currentDate: NSNumber = NSNumber(value:NSDate().timeIntervalSince1970)
        
        //When you want to print out correct date.
        //var interval = NSDate().timeIntervalSince1970
        //let currentDate: NSDate = NSDate(timeIntervalSince1970: interval)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd, H:mm:ss"
        let defaultTimeZoneStr = formatter.string(from: Date())
        
        let values = ["Location": startLabel.text, "Destination": label1.text, "Date": defaultTimeZoneStr] as [String : Any]
        
        userRideData.updateChildValues(values, withCompletionBlock: { (err,ref) in
            
            if err != nil{
                self.displayMyAlertMessage(userMessage: "Something went wrong.\nDidn't load values in database.")
                return
            }
            else{
                    self.delegate?.passengerDataSent(data: "Hello World")
                
                    let requestAlert = UIAlertController(title: "Ride Requested!", message: "Drivers Available: ", preferredStyle: UIAlertControllerStyle.alert);
                
                    requestAlert.addAction(UIAlertAction(title:"OK", style: UIAlertActionStyle.default, handler: {action in self.performSegue(withIdentifier: "destinationToMapSegue", sender: self)}));
                
                self.present(requestAlert, animated: true, completion: nil)
            }
        })
        
//        ref.child("Rides").child(uid!).observeSingleEvent(of: FIRDataEventType.value, with: { (snapshot) in
//            print(snapshot)
//            let dict = snapshot.value as? [String: AnyObject]
//            var rNum = dict?["RideNumber"] as? Int
//            
//            if rNum! < 1
//            {
//                ref.child("Rides").child(uid!).child("RideNumber").setValue(1)
//                //rNum = rNum! + 1
//            }
//            else{
//                //rNum = 2
//                //if rNum! > 1
//                //{
//                    rNum = rNum! + 1
//                ref.child("Rides").child(uid!).child("RideNumber").setValue(rNum)
//                //}
//            }
//            
//        }
//            , withCancel: nil)
        
        ref.child("Users").child(uid!).observeSingleEvent(of: FIRDataEventType.value, with: { (snapshot) in
            
            if let dict = snapshot.value as? [String: AnyObject]
            {
                let newDict = dict["RideCount"] as? NSNumber
                var rideCount = newDict?.intValue
                if rideCount == nil
                {
                    rideCount = 1
                }
                else
                {
                    rideCount = rideCount! + 1
                }
                ref.child("Users").child(uid!).child("RideCount").setValue(rideCount)
            }
        }
            , withCancel: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

protocol SendDataToDriverDelegate {
    func passengerDataSent(data: String)
}
