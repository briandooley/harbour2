//
//  ViewControllerLogin.swift
//  forum
//
//  Created by Sipan Calli on 27/07/16.
//  Copyright © 2016 FeedHenry. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewControllerLogin: UIViewController, UITextFieldDelegate {
    
    
    //MARK: Outlets

    @IBOutlet weak var labelEmail: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var termsConditionsButton: UIButton!
    @IBOutlet weak var switchTermsConditions: UISwitch!
    
    
    //MARK: Properties
    
    
    var user:User = User()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        termsConditionsButton.tintColor = UIColor.whiteColor()
        termsConditionsButton.layer.cornerRadius = 6
        termsConditionsButton.backgroundColor = UIColor.redHatLightRed()
        switchTermsConditions.onTintColor = UIColor.whiteColor()
        switchTermsConditions.tintColor = UIColor.whiteColor()
        switchTermsConditions.on = false
        buttonLogin.backgroundColor = UIColor.whiteColor()
        buttonLogin.setTitleColor(UIColor.redHatLightRed(), forState: .Normal)
        buttonLogin.titleLabel?.textColor = UIColor.redHatLightRed()
        buttonLogin.layer.cornerRadius = 6
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    private func presentPopUpController(title:String,message:String){

        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction!) in
        }))
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    
   

    
    
    @IBAction func tapTermsCondition(sender: AnyObject) {
        
        let viewControllerTermsConditions:ViewControllerTermsConditions = UIStoryboard(name: "Storyboard", bundle: nil).instantiateViewControllerWithIdentifier("ViewControllerTermsCondition") as! ViewControllerTermsConditions
        presentViewController(viewControllerTermsConditions, animated: true, completion: nil)
    }
    
    
    @IBAction func tapButtonHarbourFront(sender: AnyObject) {
        
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.harbourfront.se")!)
    }
    @IBAction func tablButtonLogin(sender: UIButton) {
        
        if let unwrappedLabelEmailText = labelEmail.text
        {
            if(!switchTermsConditions.on)
            {
                presentPopUpController("Terms and Conditions",message: "You must agree to the Terms and Conditions!")
                return
            }
            if(!unwrappedLabelEmailText.containsString("@"))
            {
                presentPopUpController("Not a valid Email address",message: "You need to provide a valid Email address")
                return
            }
            
            buttonLogin.enabled = false
            user.getCreateProfile(unwrappedLabelEmailText, completion: { (json, error) in
                if error == nil
                {
                    self.user.loginUser()
                 
                        let homeViewController:PageViewControllerQuiz = UIStoryboard(name: "Storyboard", bundle: nil).instantiateViewControllerWithIdentifier("PageViewControllerQuiz") as! PageViewControllerQuiz
                        homeViewController.user = self.user
                        self.buttonLogin.enabled = true
                        self.presentViewController(homeViewController, animated: true, completion: nil)
                
         
                }
                else
                {
                    self.buttonLogin.enabled = true
                    self.presentPopUpController("Error", message: (error?.localizedFailureReason)!)
                }
            })
        }
    }
}
