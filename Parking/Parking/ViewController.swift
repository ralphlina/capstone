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

    var name2:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        name2 = "Ralph Lina"
        print(name2)
        label.text = "CSUCI Parking"
        name.text = "Ralph & Evan"
        descrip.text = "Here is our parking app"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

