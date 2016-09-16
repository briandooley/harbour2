//
//  ViewControllerRedHadMaster.swift
//  forum
//
//  Created by Sipan Calli on 27/07/16.
//  Copyright © 2016 FeedHenry. All rights reserved.
//

import UIKit

class ViewControllerRedHadMaster: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    //Mark: Properties
    
    
    var user:User = User()
    
    //MARK: Outlets
    
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(UINib(nibName:"TableViewCellMaster",bundle: nil ), forCellReuseIdentifier: "cellMaster")
        tableView.separatorColor = UIColor.blackColor()
        tableView.separatorStyle = .SingleLineEtched
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        labelTitle.textColor = UIColor.whiteColor()
        updateLabelTitle()
        user.cloudCallMaster { 
            self.tableView.reloadData()
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    //MARK: Private Functions
    
    
 
    
    
    func updateLabelTitle(){
        if let unwrappedTotalScore = user.score
        {
            labelTitle.text = "Your score is \(unwrappedTotalScore)"
        }
        else
        {
            labelTitle.text = "Your score is 0"
        }
    }
    
    
    private func hasUserCompletedMission(missionId:Int64) -> Bool{

            for i:Int64? in user.completedMissionIds
            {
                if let iunwrapped = i{
                    if iunwrapped == missionId
                    {
                        return true
                    }
                }
            }
        return false
    }
    
    
    //MARK: TableViewDelegate and TableViewDatasource functions

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return user.masterArray.count ?? 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell : TableViewCellMaster = tableView.dequeueReusableCellWithIdentifier("cellMaster") as! TableViewCellMaster
        let master = user.masterArray[indexPath.section]
        cell.switchCompleted.onTintColor = UIColor.redHatLightRed()
        cell.switchCompleted.tintColor = UIColor.redHatLightRed()
        cell.labelPoints.textColor = UIColor.redHatLightRed()
        cell.labelDescription.textColor = UIColor.redHatDarkRed()
        cell.labelDescription.text = master.mission
        cell.selectionStyle = .None
        
        if let unwrappedMissionID = master.missionId{
            if hasUserCompletedMission(unwrappedMissionID)
            {
                cell.switchCompleted.on = true
            }
            else
            {
                cell.switchCompleted.on = false
            }
        }
        cell.missionId = master.missionId
        cell.missionPoint = master.point
        
        if let unwrappedPoint = master.point
        {
            cell.labelPoints.text = "\(unwrappedPoint)"
        }
        cell.delegate = self
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor.grayColor()
        return header
    }
}
