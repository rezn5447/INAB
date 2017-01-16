//
//  ViewController.swift
//  INAB
//
//  Created by Resdan  on 11/20/16.
//  Copyright © 2016 mwp. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    func displayAlert(title:String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleLogin(){
        guard let email = Email.text, let password = Password.text else{
            displayAlert(title: "Error", message: "Problem Signing In, Try Again")
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, err) in
            
            if err != nil {
                print(err!)
                return
            }
            
            guard let userID = FIRAuth.auth()?.currentUser?.uid else {
            self.displayAlert(title: "Error", message: "User Does not Exist")
                return
            }
            
            self.CheckUserType(user: userID)
        })
    }
    func CheckUserType(user: String){
        FIRDatabase.database().reference().child("users").child(user).observeSingleEvent(of: .value, with: {(snapshot) in
        let value = snapshot.value as! NSDictionary
        let userType = value["type"] as? String ?? ""
            if userType == "vendor" {
            self.performSegue(withIdentifier: "VendorSegue", sender: LoginViewController.self)
        }else {
            self.performSegue(withIdentifier: "LoginSegue", sender: LoginViewController.self)
            }
        })
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    // this logs the user in and creates a user in the firebase database
    
    @IBAction func Login(_ sender: Any) {
    // check to see if email and password fields have values
       handleLogin()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

