//
//  ViewController.swift
//  INAB
//
//  Created by Resdan  on 11/20/16.
//  Copyright © 2016 mwp. All rights reserved.
//

import UIKit
import Firebase
import SnapKit
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    func displayAlert(title:String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleLogin(){
        FBSDKLoginManager().logIn(withReadPermissions: ["email","public_profile"], from: self)
            {   (result, err) in
                if err != nil {
                print("FB Login Failed!", err!)
                }
           self.ShowEmailAddress()
           self.performSegue(withIdentifier: "LoginSegue", sender: LoginViewController.self)
        }
    
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
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out with Facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
    }
    // this logs the user in and creates a user in the firebase database
    func ShowEmailAddress(){
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else
           { return }
        let credentials = FIRFacebookAuthProvider.credential(withAccessToken: accessTokenString)
        FIRAuth.auth()?.signIn(with: credentials,  completion: { (user, error) in
            if error != nil {
                print("Something went wrong with our FB user: ",error ?? "")
                return
            }
            print("Successfully logged in with our user: ", user ?? "")
        })
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields" : "id,name,email"]).start { (connection, result, err) in
            if err != nil {
                print( "failed to create graph request: ",err as Any )
                return
            }
            print(result as Any)
        }
    }
    @IBAction func Login(_ sender: Any) {
    // check to see if email and password fields have values
        handleLogin()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
