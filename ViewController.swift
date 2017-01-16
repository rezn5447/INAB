//
//  ViewController.swift
//  INAB
//
//  Created by Resdan  on 11/20/16.
//  Copyright © 2016 mwp. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    func displayAlert(title:String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "PetcoBackground.png")!)
        
          let ref = FIRDatabase.database().reference()
        
        ref.updateChildValues(["some value" : 21213245321421])

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

