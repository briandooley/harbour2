//
//  ViewControllerTermsConditions.swift
//  forum
//
//  Created by Sipan Calli on 08/09/16.
//  Copyright © 2016 FeedHenry. All rights reserved.
//

import UIKit

class ViewControllerTermsConditions: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        navigationBar.tintColor = UIColor.redHatDarkRed()
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func tapBackButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}