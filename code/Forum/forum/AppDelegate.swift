/*
* Copyright Red Hat, Inc., and individual contributors
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import UIKit
import FeedHenry

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var user:User = User()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
       // user.logOutUser()
        user.populateUserFromDefaults()
        setupPageControl()
        setupTabBar()
        setupNavigationBar()
        feedHenryInit()
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
    }
    
    func applicationWillTerminate(application: UIApplication) {
    }
}

extension  AppDelegate{
    
    private func feedHenryInit(){
        FH.init {(resp: Response, error: NSError?) -> Void in
            if let error = error {
                print("FH init failed. Error = \(error)")
                if FH.isOnline == false
                {
                    print("Make sure you're online.")
                } else
                {
                    print("Please fill in fhconfig.plist file.")
                }
                return
            }
            else
            {
                self.setInitialViewController()
            }
        }
    }

    private func setInitialViewController(){

        if user.isUserLoggedIn
        {
            user.populateUserFromDefaults()
            let homeViewController = TabBarController()
            homeViewController.user = user
            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
            self.window?.rootViewController = homeViewController
            self.window?.makeKeyAndVisible()

        }
        else
        {
            let homeViewController:ViewControllerLogin = UIStoryboard(name: "Storyboard", bundle: nil).instantiateViewControllerWithIdentifier("ViewControllerLogin") as! ViewControllerLogin
            
            user.cloudCallQuestions({
                homeViewController.user = self.user
                self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
                self.window?.rootViewController = homeViewController
                self.window?.makeKeyAndVisible()
            })
        }
    }
    
    

    private func setupPageControl(){
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.redHatDarkRed()
        pageControl.currentPageIndicatorTintColor = UIColor.redHatLightRed()
        pageControl.backgroundColor = UIColor.whiteColor()
    }
    
    
    private func setupTabBar(){
        let tabBar = UITabBar.appearance()
        tabBar.tintColor = UIColor.redHatDarkRed()
        tabBar.barTintColor = UIColor.whiteColor()
    }
    
    private func setupNavigationBar(){
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.redHatLightRed()]

    }
    
}
