//
//  SignUpViewController.swift
//  INAB
//
//  Created by Resdan  on 12/4/16.
//  Copyright © 2016 mwp. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    @IBOutlet weak var ConfirmPassword: UITextField!
    
    @IBOutlet weak var Month: UITextField!
    @IBOutlet weak var Year: UITextField!
    
    
    
    func displayAlert(title:String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func signUp() {
        guard let email = Email.text, let password = Password.text, let month = Month.text, let year = Year.text else{
            displayAlert(title: "Error", message: "Form is not valid")
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            if error != nil {
                print(error!)
                self.displayAlert(title: "Error", message: error! as! String)

                return
            }
            
            guard let uid = user?.uid else {
                return
            }
            // Successfully authenticated user
            
            let usersRef = FIRDatabase.database().reference().child("users").child(uid)
            let values = ["email": email, "DOB": month + " / " + year, "type": "customer"]
            usersRef.updateChildValues(values) { (err, ref) in
                if err != nil {
                    print(err!)
                    return
                }
                
                print("Saved user successfully into Firebase db")
            }
            
            self.performSegue(withIdentifier: "SignedUpSegue", sender: Any?(self))
        })// end of FIRAuth
        

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func CreateAccount(_ sender: Any) {
        
      if Password.text == "" || ConfirmPassword.text == "" {
        print("Check Passwords Are not Empty")
        displayAlert(title: "Error", message: "Check Passwords Are not Empty")
      
      } else if Password.text != ConfirmPassword.text {
        
        print("Check Passwords match")
        displayAlert(title: "Error", message: "Check Passwords match")
        
      } else if Email.text == "" || Month.text == "" || Year.text == "" {
        displayAlert(title: "Error", message: "Check Correct Information for all Fields")
        
      }else{
        signUp()
      }
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
