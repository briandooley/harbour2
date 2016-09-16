//
//  ViewControllerProfile.swift
//  forum
//
//  Created by Sipan Calli on 27/07/16.
//  Copyright © 2016 FeedHenry. All rights reserved.
//

import UIKit

class ViewControllerProfile: UIViewController {

    
    
    //MARK: Outlets
    @IBOutlet weak var labelBottom: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var charachterImage: UIImageView!
    
    //MARK:Properties
    
    var user:User = User()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
        labelTitle.text = "You are a " + user.character
        if (user.character == "rockstar"){
            let image = UIImage(named:"icon_rh_people_rockstar_360")!
            charachterImage.image = image
        }else if (user.character == "public speaker"){
            let image = UIImage(named: "icon_rh_people_publicspeaker_360")!
            charachterImage.image = image
        }else if (user.character == "yoga guru"){
            let image = UIImage(named: "icon_rh_people_yogaguru_360")!
            charachterImage.image = image
        }else if (user.character == "nobel prize winner"){
            let image = UIImage(named: "icon_rh_people_nobelprizewinner_360")!
            charachterImage.image = image
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
