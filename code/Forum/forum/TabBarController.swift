//
//  tabBarController.swift
//  forum
//
//  Created by Sipan Calli on 28/07/16.
//  Copyright © 2016 FeedHenry. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    var user = User()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = UIColor.blackColor()
        let storyboad = UIStoryboard(name: "Storyboard", bundle: nil)
        
        let viewControllerProfile = storyboad.instantiateViewControllerWithIdentifier("ViewControllerProfile") as! ViewControllerProfile
        viewControllerProfile.user = user
        viewControllerProfile.tabBarItem.image = UIImage(named:"profile")
        viewControllerProfile.tabBarItem.title = "Profile"

                
        let viewControllerAgenda = storyboad.instantiateViewControllerWithIdentifier("ViewControllerAgenda") as! ViewControllerAgenda
        viewControllerAgenda.user = user
        viewControllerAgenda.tabBarItem.image = UIImage(named: "agenda")
        viewControllerAgenda.tabBarItem.title = "Agenda"
        
        let viewControllerRedHatMaster = storyboad.instantiateViewControllerWithIdentifier("ViewControllerRedHadMaster") as! ViewControllerRedHadMaster
        viewControllerRedHatMaster.user = user
        viewControllerRedHatMaster.tabBarItem.image = UIImage(named:"master")
        viewControllerRedHatMaster.tabBarItem.title = "Master"
        
        
        viewControllers = [viewControllerProfile,viewControllerRedHatMaster,viewControllerAgenda]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
