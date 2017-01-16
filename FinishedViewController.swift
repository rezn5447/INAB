//
//  FinishedViewController.swift
//  INAB
//
//  Created by Resdan  on 12/4/16.
//  Copyright © 2016 mwp. All rights reserved.
//

import UIKit
import Firebase

class FinishedViewController: UIViewController {
    
    var orderID = ""
    var runnerName = "Unknown"
    var Stadium = ""
    

    
    
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var runnerLabel: UILabel!
    @IBOutlet var progressBar: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderNumberLabel.text = orderID

        runnerListener()

    }
    
// This effectively updates the runner label value based on the value in Database
    func runnerListener() {
        FIRDatabase.database().reference().child("\(Stadium)/orders/\(orderID)").observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                self.runnerLabel.text = dictionary["runner"] as? String
            }
        }, withCancel: nil)
    }
    
    
    
//    func fetchStadiumsBeverages() {
//        FIRDatabase.database().reference().child(Stadium).child("beverages").observe(.childAdded, with: { (snapshot) in
//            
//            if let dictionary = snapshot.value as? [String: AnyObject] {
//                let beverage = Beverage()
//                beverage.imgUrl = dictionary["imgUrl"]  as? String
//                beverage.name   = dictionary["name"]   as? String
//                beverage.price   = dictionary["price"] as? String
//                self.beverages.append(beverage)
//                
//                DispatchQueue.main.async(execute: {
//                    self.PurchaseTableView.reloadData()
//                })
//            }
//        }, withCancel: nil)
//    }
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
