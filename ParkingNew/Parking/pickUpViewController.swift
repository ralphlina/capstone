//
//  ViewController3.swift
//  Parking
//
//  Created by Randy Lina on 3/14/17.
//  Copyright © 2017 Ralph Lina. All rights reserved.
//

import UIKit
import Firebase

class pickUpViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    var labelText = String()
    
    @IBOutlet weak var label1: UILabel!

    @IBOutlet weak var helloname: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    func displayMyAlertMessage(userMessage: String)
    {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated: true, completion: nil);
    }
    
    @IBAction func backBtnTap(_ sender: Any) {
        try! FIRAuth.auth()!.signOut()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    let locations1 = ["Library", "Student Union", "Gym", "A7", "A8", "A9", "A10", "El Dorado", "Aliso Hall", "Sierra Hall"]

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helloname.text = labelText
        // Do any additional setup after loading the view.
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let DestViewController : destinationViewController = segue.destination as! destinationViewController
        
        DestViewController.segLabel = label1.text!
        //DestViewController.labelText = entername.text!
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
