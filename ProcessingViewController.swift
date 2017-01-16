//
//  ProcessingViewController.swift
//  INAB
//
//  Created by Resdan  on 1/11/17.
//  Copyright © 2017 mwp. All rights reserved.
//

import UIKit
import Firebase

class ProcessingViewController: UIViewController {

    @IBOutlet weak var OrderIDLabel: UILabel!
    @IBOutlet weak var BeveragesLabel: UILabel!
    @IBOutlet weak var SeatLabel: UILabel!
    @IBOutlet weak var RowLabel: UILabel!
    @IBOutlet weak var TotalLabel: UILabel!
    
    var orderID   = ""
    var beverages = ""
    var seat      = ""
    var row       = ""
    var Stadium   = ""
    
    
    
    func completeOrder(_ act: UIAlertAction ){
        print("\(orderID) is now being processed")
        let orderRef = FIRDatabase.database().reference().child(Stadium).child("orders").child(orderID)
        orderRef.updateChildValues(["status" : "completed"])
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
