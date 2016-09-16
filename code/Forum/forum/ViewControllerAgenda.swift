//
//  ViewControllerAgenda.swift
//  forum
//
//  Created by Sipan Calli on 27/07/16.
//  Copyright © 2016 FeedHenry. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewControllerAgenda: UIViewController {

    @IBOutlet weak var imageAgenda: UIImageView!
    @IBOutlet weak var webView: UIWebView!
    
    var user:User = User()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
        user.cloudCallAgenda {
            if let unwrappedAgendaString = self.user.agendaString{
                self.webView.loadHTMLString(unwrappedAgendaString, baseURL: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
