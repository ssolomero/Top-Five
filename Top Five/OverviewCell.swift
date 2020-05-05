//
//  OverviewCell.swift
//  Top Five
//
//  Created by Sharence Solomero on 5/4/20.
//  Copyright © 2020 Sharence Solomero. All rights reserved.
//

import UIKit

class OverviewCell: UITableViewCell {

   
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var listLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        listLabel.layer.masksToBounds = true
        listLabel.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
