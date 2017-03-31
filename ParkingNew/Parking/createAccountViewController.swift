//
//  createAccountViewController.swift
//  Parking
//
//  Created by Navid Khoi on 3/31/17.
//  Copyright © 2017 Ralph Lina. All rights reserved.
//

import UIKit
import Firebase

class createAccountViewController: UIViewController {
    
    var ref: FIRDatabaseReference!
    
    /* https://www.youtube.com/watch?v=ORBW1FwXBrM for database implementation
    also figure out passenger/driver option
    */
    
    
    //ref = FIRDatabase.database().reference()
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var userType: UISegmentedControl!
    
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    func displayMyAlertMessage(userMessage: String)
    {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated: true, completion: nil);
    }
    
    
    @IBAction func createUser(_ sender: Any) {
        
    
    ///*
    let username = self.username.text;
    let email = userEmail.text;
    let password = userPassword.text;
    
    if((username?.isEmpty)! || (email?.isEmpty)! || (password?.isEmpty)!)
    {
    //Display alert message.
    self.displayMyAlertMessage(userMessage: "All fields are required");
    return;
    }
    
    FIRAuth.auth()?.createUser(withEmail: email!, password: password!, completion: { (user: FIRUser?, error) in
    if error == nil {
    //registration successful
    self.displayMyAlertMessage(userMessage:"User is now registered!\nYou can now log in.");
    }else{
    //registration failure
    self.displayMyAlertMessage(userMessage:"User is not registered in, try again");
    }
    })
   //*/
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        FIRApp.configure()
        
        configureDatabase()
        // Do any additional setup after loading the view.
    }

    func configureDatabase() {
        //Gets a FIRDatabaseReference for the root of your Firebase Database.
        ref = FIRDatabase.database().reference()
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
