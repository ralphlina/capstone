//
//  ViewController3.swift
//  Parking
//
//  Created by Randy Lina on 3/14/17.
//  Copyright © 2017 Ralph Lina. All rights reserved.
//

import UIKit

class ViewController3: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak var label1: UILabel!

    @IBOutlet weak var pickerView: UIPickerView!
    
    let locations1 = ["Library", "Student Union", "Gym", "A7", "A8", "A9", "A10", "El Dorado", "Aliso Hall", "Sierra Hall"]

    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return locations1[row]
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return locations1.count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        label1.text = locations1[row]
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let DestViewController : View4going = segue.destinationViewController as! View4going
        
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
