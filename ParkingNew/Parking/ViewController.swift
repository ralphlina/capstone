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
    
    
    @IBOutlet weak var enterPW: UITextField!
    @IBOutlet weak var entername: UITextField!
    
    
    @IBAction func hello(sender: AnyObject) {
        //helloname.text = "Hello \(entername.text!)!"
        //helloname.text = entername.text
    }
    
    
    func output() {
        name2 = "TESTING PRINT IN THE OUTPUT BELOW"
        print(name2)
    }
    
    func initial() {
        label.text = "CI HitchHike"
        label.font = UIFont (name: "GILLSANSCE-ROMAN", size: 60) //doesnt work. need to import font first
        
        name.text = "-Ralph & Evan"
        descrip.text = "Here is our parking app"
   
    }
    
    
    func backColor() {
        //self.view.backgroundColor = UIColor.grayColor()
        self.view.backgroundColor = UIColor(red: (255/255)*2, green: (247/255)*2, blue: (227/255)*2, alpha: 0.5)
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
    
    //override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     //   var DestViewController : View2 = segue.destinationViewController as View2
        
      //  DestViewController.labelText = "Hello \(entername.text!)!"
   // }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let DestViewController : View2 = segue.destinationViewController as! View2
        
        DestViewController.labelText = "Hello \(entername.text!)!"
        //DestViewController.labelText = entername.text!
    }
    
}

