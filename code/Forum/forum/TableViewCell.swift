//
//  TableViewCell.swift
//  forum
//
//  Created by Sipan Calli on 26/07/16.
//  Copyright © 2016 FeedHenry. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clearColor()
        labelTitle.textColor = UIColor.whiteColor()
        layer.borderColor = UIColor.whiteColor().CGColor
        layer.borderWidth = 1
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if (selected){
            labelTitle.textColor = UIColor.redHatLightRed()
            backgroundColor = UIColor.whiteColor()
        }
        else{
            labelTitle.textColor = UIColor.whiteColor()
            backgroundColor = UIColor.clearColor()
        }
    }
    
    
}
