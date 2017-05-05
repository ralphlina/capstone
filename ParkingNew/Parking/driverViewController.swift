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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        rideStatusLabel.text = "No current users need a ride."
        
        let ref = FIRDatabase.database().reference(fromURL: "https://ci-hitchhike-b028e.firebaseio.com/")
        
//        FIRAuth.auth()?.currentUser?.uid.substring(to: (FIRAuth.auth()?.currentUser?.uid.endIndex)!)
        
        ref.child("messages").observe(FIRDataEventType.value, with: { (snapshot1) in
            
            let dict = snapshot1.value as? [String: AnyObject]
            let userIDMess = dict?["UserID"] as? String
         
            ref.child("UserRides").child(userIDMess!).observe(FIRDataEventType.value, with: { (snapshot2) in
            
                    let userText = dict!["text"] as! String
                    self.rideStatusLabel.text = "\(userText)"

            
            })
            
        })
        
        //for delegate
        //destinationVC.delegate = self
        
        //for table view
       // self.driverTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    

}
