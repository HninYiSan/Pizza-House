//
//  dataTableViewCell.swift
//  PizzaSampleApp
//
//  Created by Hnin Yi on 8/24/19.
//  Copyright © 2019 Hnin Yi San. All rights reserved.
//

import UIKit

class dataTableViewCell: UITableViewCell {

    @IBOutlet weak var foodnameLabel: UILabel!
    
    @IBOutlet weak var foodpriceLabel: UILabel!
    
    @IBOutlet weak var promoLabel: UILabel!
    
    @IBOutlet weak var qtyTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
