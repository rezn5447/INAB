//
//  BeverageTableViewCell.swift
//  INAB
//
//  Created by Resdan  on 12/4/16.
//  Copyright © 2016 mwp. All rights reserved.
//

import UIKit

class BeverageTableViewCell: UITableViewCell {

    @IBOutlet weak var BeverageImage: UIImageView!
    @IBOutlet weak var QuantityField: UITextField!
    
    var price = 0.00
    var name = "dfsas"
    var imgUrl = "fdfds"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(named:String, imgUrl:String, priced:String)
    {
        self.name = named
        self.BeverageImage.image  = UIImage(named: imgUrl)
        self.price = Double(priced)!

    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
