//
//  ListItemCell.swift
//  Top Five
//
//  Created by Sharence Solomero on 5/6/20.
//  Copyright © 2020 Sharence Solomero. All rights reserved.
//

import UIKit

class ListItemCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //self.textField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    //Exit keyboard and text field when Done(return) key is pressed
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//            self.endEditing(true)
//            return false
//    }

}
