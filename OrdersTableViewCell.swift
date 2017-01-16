//
//  OrdersTableViewCell.swift
//  INAB
//
//  Created by Resdan  on 1/6/17.
//  Copyright © 2017 mwp. All rights reserved.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {

    
    @IBOutlet weak var orderIDLabel: UILabel!
    @IBOutlet weak var beveragesLabel: UILabel!
    @IBOutlet weak var seatLabel: UILabel!
    @IBOutlet weak var rowLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(orderID:String, beverages:String, total:String, seat:String, row:String)
    {
        self.orderIDLabel.text    = orderID
        self.beveragesLabel.text  = beverages
        self.totalLabel.text      = total
        self.seatLabel.text       = seat
        self.rowLabel.text        = row
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
