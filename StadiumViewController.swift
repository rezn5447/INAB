//
//  StadiumViewController.swift
//  INAB
//
//  Created by Resdan  on 12/4/16.
//  Copyright © 2016 mwp. All rights reserved.
//

import UIKit
import Firebase

class StadiumViewController: UIViewController, UIPickerViewDelegate,
UIPickerViewDataSource{

    
    @IBOutlet weak var StadiumPicker: UIPickerView!
    
    @IBOutlet weak var Seat: UITextField!
    @IBOutlet weak var Row: UITextField!

    var stadiums = [Stadium]()
    var SelectedStadium = ""
  
    
    func handleLogout() {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signoutError as NSError {
            print("Error Signing Out: ", signoutError)
        }
        
    }
    
    @IBAction func Logout(_ sender: Any) {
        handleLogout()
    }

    // Fetch Stadiums from Database
    func fetchStadiums() {
        FIRDatabase.database().reference().child("stadiumNames").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let stadium = Stadium()
                
                stadium.setValuesForKeys(dictionary)
                self.stadiums.append(stadium)
                self.SelectedStadium = self.stadiums[0].name!
                
                
                DispatchQueue.main.async(execute: {
                    self.StadiumPicker.reloadAllComponents()
                })
                
                
            }
        }, withCancel: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        StadiumPicker.dataSource = self
        StadiumPicker.delegate   = self
        
        fetchStadiums()
        
    }

    
  //  Pickerview Attributes, Datasource, ETC
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return stadiums[row].name
        
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
      return stadiums.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        SelectedStadium = stadiums[row].name!
        print(stadiums[row])
    }

    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PurchaseSegue"{
        let DestVC : PurchaseViewController = segue.destination as! PurchaseViewController
        
        DestVC.Stadium = SelectedStadium
        DestVC.Seat    = Seat.text!
        DestVC.Row     = Row.text!
            

        }
        if segue.identifier == "OrderSegue"{
            let DestVC : OrdersViewController = segue.destination as! OrdersViewController
            
            DestVC.Stadium = SelectedStadium
            
        }
    }
 

}
