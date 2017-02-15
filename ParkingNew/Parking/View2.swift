//
//  View2.swift
//  Parking
//
//  Created by Randy Lina on 1/5/17.
//  Copyright © 2017 Ralph Lina. All rights reserved.
//

import Foundation
import UIKit

class View2 : UIViewController {
    
    func backColor() {
        //self.view.backgroundColor = UIColor.grayColor()
        self.view.backgroundColor = UIColor(red: (255/255)*2, green: (247/255)*2, blue: (227/255)*2, alpha: 0.5)
    }
    
    @IBOutlet weak var helloname: UILabel!
    

    
    var labelText = String()
    
    
    override func viewDidLoad() {
        //self.view.backgroundColor = UIColor(red: (255/255)*2, green: (247/255)*2, blue: (227/255)*2, alpha: 0.5)
        backColor()
        helloname.text = labelText

    }
    
}
