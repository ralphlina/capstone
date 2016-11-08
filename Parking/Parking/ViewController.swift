//
//  ViewController.swift
//  Parking
//
//  Created by Randy Lina on 10/26/16.
//  Copyright © 2016 Ralph Lina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var descrip: UILabel!
    
    @IBOutlet weak var enternameD: UILabel!
    
    var name2:String = ""
    
    @IBOutlet weak var signin: UIButton!
    
    
    @IBOutlet weak var entername: UITextField!
    
    
    func output() {
        name2 = "TESTING PRINT IN THE OUTPUT BELOW"
        print(name2)
    }
    
    func initial() {
        label.text = "CSUCI Parking"
        name.text = "Ralph & Evan"
        descrip.text = "Here is our parking app"
        enternameD.text = "Enter name"
    }
    
    
    func backColor() {
        //self.view.backgroundColor = UIColor.grayColor()
        self.view.backgroundColor = UIColor(red: (240/255)*2, green: (230/255)*2, blue: (200/255)*2, alpha: 0.5)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        output()
        initial()
        backColor()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

