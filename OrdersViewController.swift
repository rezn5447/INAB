//
//  OrdersViewController.swift
//  INAB
//
//  Created by Resdan  on 1/6/17.
//  Copyright © 2017 mwp. All rights reserved.
//

import UIKit
import Firebase

class OrdersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var OrdersTableView: UITableView!
    let cellID = "OrdersCell"
    var orders  = [Order]()
    var Stadium = ""
    
    func fetchStadiumsOrders() {
        FIRDatabase.database().reference().child(Stadium).child("orders").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let order = Order()
                order.orderID     = snapshot.key
                order.beverages   = dictionary["order"]   as? String
                order.total       = dictionary["total"]   as? String
                order.seat        = dictionary["seat"]    as? String
                order.row         = dictionary["row"]     as? String
                self.orders.append(order)
                
                DispatchQueue.main.async(execute: {
                    self.OrdersTableView.reloadData()
                })
            }
        }, withCancel: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStadiumsOrders()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let currentCell          = tableView.cellForRow(at: indexPath) as! OrdersTableViewCell
        let currentCellID        = currentCell.orderIDLabel.text!
        let currentCellBeverages = currentCell.beveragesLabel.text!
        let currentCellRow       = currentCell.rowLabel.text!
        let currentCellSeat      = currentCell.seatLabel.text!
        
        func processOrderAlert(title:String, message: String){
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: processOrder ))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        func processOrder(_ act: UIAlertAction ){
        
            self.performSegue(withIdentifier: "ExpediteSegue", sender: self)
            print("\(currentCellID) is now being processed")
            let orderRef = FIRDatabase.database().reference().child(Stadium).child("orders").child(currentCellID)
            orderRef.updateChildValues(["status" : "processing"])
        }
        processOrderAlert(title: "Hey", message: "Process This Order?")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrdersTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID) as! OrdersTableViewCell
        let ord = orders[indexPath.row]
        cell.setCell(orderID: ord.orderID!, beverages: ord.beverages!, total: ord.total!, seat: ord.seat!, row: ord.row!)
        return cell
    }
    
  //   MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ExpediteSegue" {
            let DestVC: ProcessingViewController = segue.destination as! ProcessingViewController
            DestVC.orderID = ""
       }
    }
 

}
