//
//  TableViewCellMaster.swift
//  forum
//
//  Created by Sipan Calli on 18/08/16.
//  Copyright © 2016 FeedHenry. All rights reserved.
//

import UIKit

class TableViewCellMaster: UITableViewCell {
    
    //MARK: Properties
    
    var delegate: ViewControllerRedHadMaster?
    var missionId : Int64?
    var missionPoint :Int64?

    
    //MARK: Outlets
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelPoints: UILabel!
    @IBOutlet weak var switchCompleted: UISwitch!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func tapSwitchCompleted(sender: UISwitch) {
        delegate?.tableView.allowsSelection = false
        if let unwrappedMissionId = missionId{
            if let unwrappedMissionPoint = missionPoint
            {
                self.delegate?.user.updateCompletedMissions(unwrappedMissionId, missionPoint: unwrappedMissionPoint, completion: { (json, error) in
                    if (error == nil)
                    {
                        self.delegate?.updateLabelTitle()
                        self.delegate?.tableView.allowsSelection = true
                    }
                    else
                    {
                        print(error?.localizedDescription)
                        self.delegate?.tableView.allowsSelection = true
                    }
                })
            }
        }
    }
}
