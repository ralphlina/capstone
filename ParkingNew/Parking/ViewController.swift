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
                //registration successful
                //self.displayMyAlertMessage(userMessage: "Signed in as " + self.entername.text!);
                self.performSegue(withIdentifier: "logintoView3", sender: self)
                self.entername.text = nil;
                self.enterPW.text = nil;
            }
        })
        
    }
    
    @IBAction func logoutBtnTap(_ sender: Any) {
        
        try! FIRAuth.auth()?.signOut();
        
        self.displayMyAlertMessage(userMessage: "Signed out");
        self.entername.text = nil;
        self.enterPW.text = nil;
    }
    
    
    func backColor() {
        //self.view.backgroundColor = UIColor.grayColor()
        self.view.backgroundColor = UIColor(red: (255/255)*2, green: (247/255)*2, blue: (227/255)*2, alpha: 0.5)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        backColor()
        
        FIRApp.configure()

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

