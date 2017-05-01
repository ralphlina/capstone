//
//  messageController.swift
//  Parking
//
//  Created by Randy Lina on 3/28/17.
//  Copyright © 2017 Ralph Lina. All rights reserved.
//

import UIKit
import Firebase

class driverViewController: UIViewController, SendDataToDriverDelegate {
    
    
    
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
    
    let destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "destinationVC") as! destinationViewController
    
    func passengerDataSent(data : String)
    {
        //print("\n", data, "\n")
        self.displayMyAlertMessage(userMessage: "Hello World!")
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        destinationVC.delegate = self

        // Do any additional setup after loading the view.
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
