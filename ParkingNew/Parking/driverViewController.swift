//
//  messageController.swift
//  Parking
//
//  Created by Randy Lina on 3/28/17.
//  Copyright © 2017 Ralph Lina. All rights reserved.
//

import UIKit
import Firebase

//SendDataToDriverDelegate (<- add if trying to pass data with delegate
class driverViewController: UIViewController{
    
    @IBOutlet weak var rideStatusLabel: UILabel!
    
    var rideStatus = String()
    
    func rideProgress()
    {
        rideStatusLabel.text = "Ride in Progress...."
    }
    
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
    
    // let destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "destinationVC") as! destinationViewController
    
    //    func passengerDataSent(data : String)
    //    {
    //        //print("\n", data, "\n")
    //        self.displayMyAlertMessage(userMessage: "Hello World!")
    //    }
    
    
    //FIRDatabase.database().reference().child("users")
    
    @IBAction func listBtnTap(_ sender: Any) {
        
        if self.rideStatusLabel.text == "Ride in Progress...."
        {
            self.displayMyAlertMessage(userMessage: "Ride is already currently in progress.")
        }
        else if self.rideStatusLabel.text == "No current users need a ride."
        {
            self.displayMyAlertMessage(userMessage: "Apparently, no one needs a ride right now.")
        }
        else
        {
            self.performSegue(withIdentifier: "driverToList", sender: self)
        }
    }
    
    @IBAction func notifyUserBtnTap(_ sender: Any) {
        
        let ref = FIRDatabase.database().reference(fromURL: "https://ci-hitchhike-b028e.firebaseio.com/")
        
        if self.rideStatusLabel.text == "Ride in Progress...."
        {
            let driverAlert = UIAlertController(title: "Ride", message: "Do you want to notify the user that you've made it to their location and you're ready to transport them?", preferredStyle: UIAlertControllerStyle.alert)
            
            let yesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { UIAlertAction in
                
                ref.child("Drivers").child((FIRAuth.auth()?.currentUser?.uid)!).observeSingleEvent(of: FIRDataEventType.value, with: { snapshot in
                    
                    let dict = snapshot.value as? [String: AnyObject]
                    if let listId = dict?["listId"] as? String
                    {
                        //                        print(listId)
                        ref.child("messages").child(listId).removeValue()
                        self.setTextFieldValue()
                    }
                    else
                    {
                        print("Error. List Id was unable to be stored.")
                    }
                    
                    
                    
                })
                
            })
            
            let noAction = UIAlertAction(title: "Not Yet", style: UIAlertActionStyle.default, handler:nil)
            
            driverAlert.addAction(yesAction)
            driverAlert.addAction(noAction)
            
            self.present(driverAlert, animated: true, completion: nil)
        }
        else
        {
            self.displayMyAlertMessage(userMessage: "No rides in progress.\nSo no users to notify.")
        }
        
        
    }
    

    
    func setTextFieldValue()
    {
        self.rideStatusLabel.text = "No current users need a ride."
        
        let ref = FIRDatabase.database().reference(fromURL: "https://ci-hitchhike-b028e.firebaseio.com/")
        
        //        FIRAuth.auth()?.currentUser?.uid.substring(to: (FIRAuth.auth()?.currentUser?.uid.endIndex)!)
        
        ref.child("messages").observe(FIRDataEventType.childAdded, with: { (snapshot1) in
            
            let dict = snapshot1.value as? [String: AnyObject]
            let userIDMess = dict?["UserID"] as? String
            
            if userIDMess == nil
            {
                self.rideStatusLabel.text = "No current users need a ride."
            }
            else
            {
                self.rideStatusLabel.text = "There are users who are in need of your assistance. Go to List"
            }
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        rideStatusLabel.text = "No current users need a ride."
        
        setTextFieldValue()
        
        //for delegate
        //destinationVC.delegate = self
        
        //for table view
        // self.driverTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(rideProgress), name: NSNotification.Name(rawValue: "ride progress"), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
}
