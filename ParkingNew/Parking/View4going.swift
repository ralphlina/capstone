//
//  View4going.swift
//  Parking
//
//  Created by Randy Lina on 3/14/17.
//  Copyright © 2017 Ralph Lina. All rights reserved.
//

import UIKit

class View4going: UIViewController {

    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    
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
        startLabel.text = segLabel
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
