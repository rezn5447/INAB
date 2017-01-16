//
//  ConfirmViewController.swift
//  INAB
//
//  Created by Resdan  on 12/4/16.
//  Copyright © 2016 mwp. All rights reserved.
//

import UIKit
import Firebase
class ConfirmViewController: UIViewController {

    
    var Stadium   = ""
    var Seat      = ""
    var Row       = ""
    var SubTotal  = "0.00"
    var Tax       = "0.00"
    var Total     = "0.00"
    var orderID   = ""
    var Order     = [String]()
    var Purchases = [String: NSArray]()
    
    @IBOutlet weak var RowLabel: UILabel!
    @IBOutlet weak var SeatLabel: UILabel!
    @IBOutlet weak var SubtotalLabel: UILabel!
    @IBOutlet weak var TaxLabel: UILabel!
    @IBOutlet weak var TotalLabel: UILabel!
    
    func displayAlert(title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RowLabel.text      = Row
        SeatLabel.text     = Seat
        SubtotalLabel.text = String(SubTotal)
        TaxLabel.text      = String(Tax)
        TotalLabel.text    = String(Total)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func placeOrder() {
        let newOrderRef = FIRDatabase.database().reference().child(Stadium).child("orders").childByAutoId()
        let ordersRef = FIRDatabase.database().reference().child(Stadium).child("orders")
        let values = ["seat": Seat, "row": Row, "total": Total, "order": Order.joined(separator: ","), "runner": "Unknown"]
        newOrderRef.updateChildValues(values) { (err, ref) in
            if err != nil {
                print(err!)
                return
            }
        
                }
        // this grabs the newly placed order ID for reference in the order placed category
        ordersRef.queryLimited(toLast: 1).observe(.childAdded, with: { (snapshot) in
        self.GrabOrder(order: snapshot.key)
        }, withCancel: nil)

    }
    // let x = 1.23556789
    // let y = Double(round(1000*x)/1000)
    
    @IBAction func PlaceOrder(_ sender: Any) {
        placeOrder()
    }
    
    func GrabOrder (order: String){
        orderID = order
        performSegue(withIdentifier: "PlaceOrderSegue", sender: Any?(self))
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChangeSegue"{
            let DestVC : PurchaseViewController = segue.destination as! PurchaseViewController
            
            DestVC.Stadium = Stadium
            DestVC.Row     = Row
            DestVC.Seat    = Seat
            
        }
        if segue.identifier == "PlaceOrderSegue"{
            let DestVC : FinishedViewController = segue.destination as! FinishedViewController
            DestVC.orderID = orderID
            DestVC.Stadium = Stadium
    
        }
        
    }
   

}
