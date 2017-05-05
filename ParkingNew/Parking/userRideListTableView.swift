//
//  userRideListTableView.swift
//  Parking
//
//  Created by Navid Khoi on 5/2/17.
//  Copyright © 2017 Ralph Lina. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class userRideListTableView: UITableViewController{
    
    @IBOutlet var driverTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //for table view
        //self.driverTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    @IBAction func backBtnTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    var sample: [String] = ["test", "went", "well"]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sample.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell:UITableViewCell = self.driverTableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        cell.textLabel?.text = sample[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.displayMyAlertMessage(userMessage: "You selected cell \(indexPath.row)!")
        
    }
    
    
    
    func displayMyAlertMessage(userMessage: String)
    {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated: true, completion: nil);
    }
    
    
}
