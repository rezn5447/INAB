//
//  Constants.swift
//  INAB
//
//  Created by Resdan  on 11/20/16.
//  Copyright © 2016 testproj. All rights reserved.
//

import Foundation

struct Constants {
    
    // MARK: NotificationKeys
    
    struct notificationKeys {
        static let SignedIn = "onSignInCompleted"
    }
    
    // MARK: Stadiums
    
    struct stadium {
        static let name = "name"
        static let location = "location"
        static let imageUrl = "imageUrl"
    }
    
    // MARK: Beverages
    
    struct beverage {
         let name  : String!
         let price : Float!
        
    }
    
    // MARK: Orders
    
    struct order {
         let orderId     : String!
         let seat        : String!
         let row         : String!
         let order       : Array<Any>!
         let total       : Float!
        
    }
}
