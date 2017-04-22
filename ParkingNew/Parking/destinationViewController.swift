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

    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    
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
    
    
    var segLabel = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //FIRApp.configure()
        //startLabel.text = segLabel
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
