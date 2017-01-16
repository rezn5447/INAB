//
//  PurchaseViewController.swift
//  INAB
//
//  Created by Resdan  on 12/4/16.
//  Copyright © 2016 mwp. All rights reserved.
//

import UIKit
import Firebase


class PurchaseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var PurchaseTableView: UITableView!
    
    let cellId     = "BeverageCell"
    var Stadium    = ""
    var Seat       = ""
    var Row        = ""
    var tax        = 0.00
    var subTotal   = 0.00
    var grandTotal = 0.00
    var beverages  = [Beverage]()
    var order      = [String]()
    var Purchases  = [String: NSArray]()
    var totalAry   = [Double]()

    
    func fetchStadiumsBeverages() {
        FIRDatabase.database().reference().child(Stadium).child("beverages").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let beverage = Beverage()
                beverage.imgUrl = dictionary["imgUrl"]  as? String
                beverage.name   = dictionary["name"]   as? String
                beverage.price   = dictionary["price"] as? String
                self.beverages.append(beverage)
                
                DispatchQueue.main.async(execute: {
                    self.PurchaseTableView.reloadData()
                })
            }
        }, withCancel: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        fetchStadiumsBeverages()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beverages.count
    }
    
    @IBAction func FirstTouch(_ sender: UITextField) {
         let PurchaseCell = sender.superview!.superview as! BeverageTableViewCell
            removePurchase(name: PurchaseCell.name)
    }

    @IBAction func MoneyCalc(_ sender: UITextField) {
        let PurchaseCell = sender.superview!.superview as! BeverageTableViewCell
        let quantity = PurchaseCell.QuantityField.text
      
        if quantity == nil || quantity == "0" || quantity?.isEmpty == true {
            removePurchase(name: PurchaseCell.name)
        }else if quantity != nil{
            let quant =    Double(PurchaseCell.QuantityField.text!)
            let name  =    PurchaseCell.name
            let price =    PurchaseCell.price
            addPurchase(name: name, price: price, quantity: quant!)
        }
    }
    
    func addPurchase (name: String, price: Double, quantity: Double){
        Purchases[name] = [quantity, price]
    }
    
    func removePurchase (name:String){
        Purchases.removeValue(forKey: name)
    }
    
    func calculateTotal(){
        let values = Array(Purchases.values)
        let keys   = Array(Purchases.keys)
        
        for (index, element) in values.enumerated() {
        
            let q = element.firstObject! as! Double
            let p = element.lastObject!  as! Double
            let total = q * p
            totalAry.append(total)
            order.append("\(keys[index])[\(q)]")
        }
        print(order)
        let t        = totalAry.reduce(0.00) { $0 + $1 }
        subTotal     = t.roundTo(places: 2)
        tax          = (subTotal / 10).roundTo(places: 2)
        grandTotal   = (subTotal + tax)
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BeverageTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId) as! BeverageTableViewCell
        
        let bev = beverages[indexPath.row]
        cell.setCell(named: bev.name!, imgUrl: bev.imgUrl!, priced: bev.price!)
    
        func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            self.view.endEditing(true)
            }
        func textFieldShouldReturn(textField : UITextField) -> Bool{
            self.view.endEditing(true)
            cell.QuantityField.resignFirstResponder()
            return true
        }
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ConfirmSegue"{
            calculateTotal()
            let DestVC : ConfirmViewController = segue.destination as! ConfirmViewController
            
            DestVC.Stadium    = Stadium
            DestVC.Order      = order
            DestVC.Row        = Row
            DestVC.Seat       = Seat
            DestVC.Tax        = String(tax)
            DestVC.Total      = String(grandTotal)
            DestVC.SubTotal   = String(subTotal)
            DestVC.Purchases  = Purchases
        }
       
    }
 
}


extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
