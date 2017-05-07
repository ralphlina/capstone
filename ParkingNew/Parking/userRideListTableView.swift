//
//  userRideListTableView.swift
//  Parking
//
//  Created by Navid Khoi on 5/2/17.
//  Copyright © 2017 Ralph Lina. All rights reserved.
//

import UIKit
import Firebase

class userRideListTableView: UITableViewController{
    
    var userList = [String]()
    var otherList = [UserRides]()
    
    var ref = FIRDatabase.database().reference(fromURL: "https://ci-hitchhike-b028e.firebaseio.com/")
//    var rideCount = 0

    override func viewDidLoad() {
        
        fetchUser()
        super.viewDidLoad()
        
//        ref = FIRDatabase.database().reference(fromURL: "https://ci-hitchhike-b028e.firebaseio.com/")
        
        self.tableView.register(UserCell.self, forCellReuseIdentifier: "cellId")
        
    }
    
    func fetchUser()
    {
//        let ref = FIRDatabase.database().reference(fromURL: "https://ci-hitchhike-b028e.firebaseio.com/")
        
//        let uid = FIRAuth.auth()?.currentUser?.uid
        
        self.ref.child("messages").observeSingleEvent(of: FIRDataEventType.value, with: { snapshot1 in
         
            for child in (snapshot1.value as? [String: AnyObject])!
            {
                self.ref.child("messages").child(child.key).observeSingleEvent(of: FIRDataEventType.value, with: { snapshot3 in
                 
                        let newdict = snapshot3.value as? [String: AnyObject]
                        let userId = newdict?["UserID"] as! String
                        let rideId = newdict?["rideID"] as! String
                
                     self.ref.child("UserRides").child(userId).child(rideId).observe(FIRDataEventType.value, with: { snapshot2 in
                        
        //                print("User found")
        //                print(snapshot2)
                        
                        if let dict2 = snapshot2.value as? [String: AnyObject]
                        {
        //                    print("dict2 = \(dict2)")
                            let userRide = UserRides()
                            userRide.setValuesForKeys(dict2)
                            
        //                    let username = dict2["username"] as! String
        //                    let date = dict2["Date"] as! String
        //                    let dest = dict2["Destination"] as! String
        //                    let loc = dict2["Location"] as! String
        //                    
        //                    self.userList.append(username)
        //                    self.userList.append(date)
        //                    self.userList.append(dest)
        //                    self.userList.append(loc)

                            self.otherList.append(userRide)
                            
                            DispatchQueue.main.async(execute: {
                                self.tableView.reloadData()
                            })
                        }
                    
                    })
                })
            }
            
        })
    }
    

    @IBAction func backBtnTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        fetchUser()
        return otherList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell:UITableViewCell = self.driverTableView.dequeueReusableCell(withIdentifier: "cellId")! as UITableViewCell
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        
        
        let user = otherList[indexPath.row]
        cell.textLabel?.text = "\(user.username!)   Time: \(user.date!)"
        cell.detailTextLabel?.text = "Current Location:\(user.location!)    Desired Destination:\(user.destination!)"
        
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
    
//    print(self.sample.first!, self.sample.last! , self.rideCount)
    
}

class UserCell: UITableViewCell{
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
