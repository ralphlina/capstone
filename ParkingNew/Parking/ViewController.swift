//
//  ViewController.swift
//  Parking
//
//  Created by Randy Lina on 10/26/16.
//  Copyright © 2016 Ralph Lina. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let ref = FIRDatabase.database().reference(fromURL: "https:ci-hitchhike-b028e.firebaseio.com/")
        backColor()
        
        //FIRApp.configure()
        
    }

    @IBOutlet weak var label: UILabel!

    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var enterPW: UITextField!
    @IBOutlet weak var entername: UITextField!
    
    @IBOutlet weak var image: UIImageView!
    
    func displayMyAlertMessage(userMessage: String)
    {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated: true, completion: nil);
    }
    
    @IBAction func signinBtnTap(_ sender: Any) {
        
//        let ref = FIRDatabase.database().reference().child("Users");
//        let uid = FIRAuth.auth()?.currentUser?.uid;
        
        let userEmail = entername.text;
        let userPassword = enterPW.text;
        
        if((userEmail?.isEmpty)! || (userPassword?.isEmpty)!)
        {
            //Display alert message.
            self.displayMyAlertMessage(userMessage: "All fields are required");
            return;
        }
        
        FIRAuth.auth()?.signIn(withEmail: userEmail!, password: userPassword!, completion: { (user: FIRUser?, error) in
            if error != nil {
                //registration failure
                self.displayMyAlertMessage(userMessage: "Error in email or password fields");
            }else{
                
                let uid = FIRAuth.auth()?.currentUser?.uid
                
                let ref = FIRDatabase.database().reference(fromURL: "https://ci-hitchhike-b028e.firebaseio.com/")
                
                ref.child("Users").child(uid!).observeSingleEvent(of: FIRDataEventType.value, with: { (snapshot) in
                    
                    if let dict = snapshot.value as? [String: AnyObject]
                    {
                        let newDict = dict["Type"] as? String
                            if newDict == "Driver"
                            {
                                try! FIRAuth.auth()!.signOut()
                                //print(newDict)
                                self.displayMyAlertMessage(userMessage: "You're account type is a driver.\nLogging out.")
                            }
                        else
                            {
                                //print(newDict)
                                //self.displayMyAlertMessage(userMessage: "Success!!!")
                                self.performSegue(withIdentifier: "logintoView3", sender: self)
                        }
                      //self.displayMyAlertMessage(userMessage: "We got something!")
                    }
                    
                }
                    , withCancel: nil)
                
                //    self.performSegue(withIdentifier: "logintoView3", sender: self)
                    self.entername.text = nil;
                    self.enterPW.text = nil;
                
//                    self.displayMyAlertMessage(userMessage: "What is goin on?" );
            }
        })
        
    }
    
    @IBAction func loginDriverBtnTap(_ sender: Any) {
        
        let userEmail = entername.text;
        let userPassword = enterPW.text;
        
        if((userEmail?.isEmpty)! || (userPassword?.isEmpty)!)
        {
            //Display alert message.
            self.displayMyAlertMessage(userMessage: "All fields are required");
            return;
        }
        
        FIRAuth.auth()?.signIn(withEmail: userEmail!, password: userPassword!, completion: { (user: FIRUser?, error) in
            if error != nil {
                //registration failure
                self.displayMyAlertMessage(userMessage: "Error in email or password fields");
            }else{
                
                let uid = FIRAuth.auth()?.currentUser?.uid
                
                let ref = FIRDatabase.database().reference(fromURL: "https://ci-hitchhike-b028e.firebaseio.com/")
                
                ref.child("Users").child(uid!).observeSingleEvent(of: FIRDataEventType.value, with: { (snapshot) in
                    
                    if let dict = snapshot.value as? [String: AnyObject]
                    {
                        let newDict = dict["Type"] as? String
                        if newDict == "Passenger"
                        {
                            try! FIRAuth.auth()!.signOut()
                            //print(newDict)
                            self.displayMyAlertMessage(userMessage: "You're account type is a passenger.\nLogging out.")
                        }
                        else
                        {
                            //print(newDict)
                            self.displayMyAlertMessage(userMessage: "Signed in as Driver!")
                            //self.performSegue(withIdentifier: "logintoView3", sender: self)
                        }
                        //self.displayMyAlertMessage(userMessage: "We got something!")
                    }
                    
                }
                    , withCancel: nil)
                
                //    self.performSegue(withIdentifier: "logintoView3", sender: self)
                self.entername.text = nil;
                self.enterPW.text = nil;
                
                //                    self.displayMyAlertMessage(userMessage: "What is goin on?" );
            }
        })
    }
    
    
    @IBAction func logoutBtnTap(_ sender: Any) {
        
        try! FIRAuth.auth()!.signOut()
        
        self.displayMyAlertMessage(userMessage: "Signed out");
        self.entername.text = nil;
        self.enterPW.text = nil;
    }
    
    
    func backColor() {
        //self.view.backgroundColor = UIColor.grayColor()
        self.view.backgroundColor = UIColor(red: (255/255)*2, green: (247/255)*2, blue: (227/255)*2, alpha: 0.5)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     //   var DestViewController : View2 = segue.destinationViewController as View2
        
      //  DestViewController.labelText = "Hello \(entername.text!)!"
   // }

/*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let DestViewController : ViewController3 = segue.destination as! ViewController3
        
        DestViewController.labelText = "Hello \(entername.text!)!"
        //DestViewController.labelText = entername.text!
    }
    */
}

