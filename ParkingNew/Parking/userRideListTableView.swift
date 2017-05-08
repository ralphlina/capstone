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
                    let rideId1 = newdict?["rideID"] as! String
                    
                    self.ref.child("UserRides").child(userId).child(rideId1).observe(FIRDataEventType.value, with: { snapshot2 in
                        
                        //                print("User found")
                        //                print(snapshot2)
                        
                        if let dict2 = snapshot2.value as? [String: AnyObject]
                        {
                            //                    print("dict2 = \(dict2)")
                            let userRide = UserRides()
                            userRide.setValuesForKeys(dict2)
                            //                            userRide.setValue(rideId1, forKey: "rideId")
                            
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
        cell.detailTextLabel?.text = "From:\(user.location!)    To:\(user.destination!)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = otherList[indexPath.row]
        //        self.displayMyAlertMessage(userMessage: "You selected cell \(indexPath.row + 1)!")
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        
        let suid = uid!.substring(to: (FIRAuth.auth()?.currentUser?.uid.endIndex)!)
        
        let driverAlert = UIAlertController(title: "Ride", message: "Do you accept this ride request for \(user.username!)?", preferredStyle: UIAlertControllerStyle.alert)
        
        let acceptAction = UIAlertAction(title: "Accept", style: UIAlertActionStyle.default, handler: { UIAlertAction in
            
            self.ref.child("Drivers").child((FIRAuth.auth()?.currentUser?.uid)!).observeSingleEvent(of: FIRDataEventType.value, with: { (snapshot) in
                
                if let dict = snapshot.value as? [String: AnyObject]
                {
                    //                    self.ref.child("Drivers").child(dict.key).observeSingleEvent(of: FIRDataEventType.value, with: { snap1 in
                    let newDict = dict["DriveCount"] as? NSNumber
                    //                        let driverName = dict["driver"] as? String
                    var rideCount = newDict?.intValue
                    if rideCount == nil
                    {
                        rideCount = 1
                    }
                    else
                    {
                        rideCount = rideCount! + 1
                    }
                    self.ref.child("Drivers").child(uid!).child("DriveCount").setValue(rideCount)
                    //                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ride in progress"), object: nil) //For user to recieve notification in mapview
                    
                    self.ref.child("messages").observeSingleEvent(of: FIRDataEventType.value, with: { snap in
                        
                        for child in (snap.value as? [String: AnyObject])!
                        {
                            
                            self.ref.child("messages").child(child.key).observeSingleEvent(of: FIRDataEventType.value, with: { snapshot3 in
                                
                                let newdict = snapshot3.value as? [String: AnyObject]
                                let userId = newdict?["UserID"] as! String
                                let rideId = newdict?["rideID"] as! String
                                
                                //                                print(child.key)
                                //                                print(child.value)
                                
                                self.ref.child("Drivers").child(uid!).updateChildValues(["listId": child.key])
                                self.ref.child("UserRides").child(userId).child(rideId).updateChildValues(["DriverId": suid])
                                
                            })
                        }
                    })
                    
                }
            }
                , withCancel: nil)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ride progress"), object: nil)
            self.dismiss(animated: true, completion: nil)
        })
        
        let holdAction = UIAlertAction(title: "Decline", style: UIAlertActionStyle.default, handler:nil)
        
        driverAlert.addAction(acceptAction)
        driverAlert.addAction(holdAction)
        
        self.present(driverAlert, animated: true, completion: nil)
        
    }
    
    //    func showAlert(_ VC : UIViewController, andMessage message: String , handler :@escaping(UIAlertAction) -> Void){
    //
    //        let alert = UIAlertController(title: "Ride Accepted", message: message , preferredStyle: UIAlertControllerStyle.alert)
    //        alert.addAction(UIAlertAction(title: "Ok", style:UIAlertActionStyle.default, handler: handler))
    //        VC.present(alert, animated: true, completion: nil)
    //
    //    }
    
    func displayMyAlertMessage(userMessage: String)
    {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated: true, completion: nil);
    }
    
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
