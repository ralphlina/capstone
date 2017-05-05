//
//  createAccountViewController.swift
//  Parking
//
//  Created by Navid Khoi on 3/31/17.
//  Copyright © 2017 Ralph Lina. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class createAccountViewController: UIViewController {
    
    var ref: FIRDatabaseReference!
    
    /* https://www.youtube.com/watch?v=ORBW1FwXBrM for database implementation
    also figure out passenger/driver option
    */
    
    
    //ref = FIRDatabase.database().reference()
    @IBAction func backBtnTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var userType: UISegmentedControl!
    var userTypeVar = "Passenger"
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //FIRApp.configure()
        //ref = FIRDatabase.database().reference()
        
        //configureDatabase()
        // Do any additional setup after loading the view.
    }
    
    /*
     func configureDatabase() {
     //Gets a FIRDatabaseReference for the root of your Firebase Database.
     //ref = FIRDatabase.database().reference()
     }
     */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayMyAlertMessage(userMessage: String)
    {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated: true, completion: nil);
    }
    
    
    @IBAction func indexChanged(_ sender: Any) {
        
        switch userType.selectedSegmentIndex
        {
        case 0:
            userTypeVar = "Passenger";
        case 1:
            userTypeVar = "Driver";
        default:
            //self.userTypeVar = "Passenger";
            break; 
        }
    }
    
    @IBAction func createUser(_ sender: Any) {
        
    
    ///*
    let username = self.username.text;
    let email = userEmail.text;
    let password = userPassword.text;
    
        
    //let userEmail = entername.text;
    //let userPassword2 = enterPW.text;
        let password2 = String(password!)
        //
        // ENCRYPT PASSWORD TO MATCH
        var encryptedPass = ""
        for uni in password2!.unicodeScalars {
            var val = uni.value
            val += 1 // or whatever ...
            //}
            encryptedPass.append(Character(UnicodeScalar(val)!))
        }
        // encrypt done
        //
        
        
    if((username?.isEmpty)! || (email?.isEmpty)! || (password?.isEmpty)!)
    {
    //Display alert message.
    self.displayMyAlertMessage(userMessage: "All fields are required");
    return;
    }
    
    FIRAuth.auth()?.createUser(withEmail: email!, password: encryptedPass, completion: { (user: FIRUser?, error) in
    if error != nil {
        //registration failure
        self.displayMyAlertMessage(userMessage:"User is not registered in, try again");
    }else{
        //registration successful
        //self.ref.child("Users").childByAutoId().setValue(["username": username, "Email": email, "Type": self.userTypeVar, "Password": password]);
        
        let createAcctAlert = UIAlertController(title: "New User", message: "Account Created!", preferredStyle: UIAlertControllerStyle.alert);
        
        guard let uid = user?.uid else{
            return
        }
        
        //let ref = FIRDatabase.database().reference(fromURL: "https://ci-hitchhike-b028e.firebaseio.com/").child("Users").child(uid)
        let ref = FIRDatabase.database().reference(fromURL: "https://ci-hitchhike-b028e.firebaseio.com/")
        
        //let values = ["username": username, "Email": email, "Password": password, "Type": self.userTypeVar]
        if self.userTypeVar == "Passenger"
        {
            let values = ["username": username, "Email": email, "Password": encryptedPass, "RideCount": "0"]
            ref.child("Users").child(uid).updateChildValues(values, withCompletionBlock: { (err,ref) in
            
                if err != nil{
                    self.displayMyAlertMessage(userMessage: "Something went wrong.\nTry again.")
                    return
                }
                else{
                    //self.displayMyAlertMessage(userMessage: "New User created successfully!")
//                    createAcctAlert.addAction(UIAlertAction(title:"OK", style: UIAlertActionStyle.default, handler: {action in self.performSegue(withIdentifier: "createAccounttoView3", sender: self)}));
                
                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
                    
                    createAcctAlert.addAction(UIAlertAction(title:"Ok", style: UIAlertActionStyle.default, handler: {action in self.present(viewController, animated: true, completion: nil) }))
                    
                    self.present(createAcctAlert, animated: true, completion: nil)
                }
                })
        }
        else
        {
            let values = ["username": username, "Email": email, "Password": encryptedPass, "DriveCount": "0"]
            ref.child("Drivers").child(uid).updateChildValues(values, withCompletionBlock: { (err,ref) in
                
                if err != nil{
                    self.displayMyAlertMessage(userMessage: "Something went wrong.\nTry again.")
                    return
                }
                else{
                    let createDriverAlert = UIAlertController(title: "New Driver", message: "Account Created!", preferredStyle: UIAlertControllerStyle.alert);
                    
//                    createAcctAlert.addAction(UIAlertAction(title:"OK", style: UIAlertActionStyle.default, handler: {action in self.performSegue(withIdentifier: "createAccounttoView3", sender: self)}));
                    
                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
                    
                    createDriverAlert.addAction(UIAlertAction(title:"Ok", style: UIAlertActionStyle.default, handler: {action in self.present(viewController, animated: true, completion: nil) }))
//                    
//                    self.present(createAcctAlert, animated: true, completion: nil)
                    self.present(animated: true, completion: nil)
                }
            })
        }
        //alert.addAction(UIAlertAction(title:"OK", style: .Default, handler:  { action in self.performSegueWithIdentifier("mySegueIdentifier", sender: self) }
        //createAcctAlert.addAction(UIAlertAction(title:"OK", style: UIAlertActionStyle.default, handler: {action in self.performSegue(withIdentifier: "createAccounttoView3", sender: self)}));
        
        //self.present(createAcctAlert, animated: true, completion: nil)
        //self.performSegue(withIdentifier: "createAccounttoView3", sender: self);
        
        //self.displayMyAlertMessage(userMessage:"New User is now registered!\nYou can now log in.");
        
        self.username.text = nil;
        self.userEmail.text = nil;
        self.userPassword.text = nil;
    }
    })
   //*/
        
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
