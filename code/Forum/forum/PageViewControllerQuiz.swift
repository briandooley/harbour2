//
//  PageViewControllerQuestionsAndAnswers.swift
//  forum
//
//  Created by Sipan Calli on 26/07/16.
//  Copyright © 2016 FeedHenry. All rights reserved.
//

import UIKit

class PageViewControllerQuiz: UIPageViewController {
    
    
    //Mark: Properties
    
    
    private var orderedViewControllers = [UIViewController]()
    private var viewControllersQuiz = [ViewControllerQuiz]()
    var user:User = User()
    
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        newViewController()
        if let firstViewController = self.orderedViewControllers.first {
            self.setViewControllers([firstViewController],direction: .Forward, animated: true, completion: nil)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    
    private func newViewController() {
        var i = 0
        for quest in (user.questionsArray)
        {
            let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
            let controller : ViewControllerQuiz = storyboard.instantiateViewControllerWithIdentifier("ViewControllerQuiz") as! ViewControllerQuiz
            if (quest.questionId ==  user.questionsArray.last?.questionId)
            {
                controller.isLast = true
            }
            controller.question = quest
            controller.pageViewControllerDelegate = self
            controller.pageIndex = i
            orderedViewControllers.append(controller)
            viewControllersQuiz.append(controller)
            i += 1
        }
    }
    
    
    //MARK: Public functions
    
    
    func hasAllQuestionsBeenAnswered() -> Bool{
        for viewControllerQuiz in viewControllersQuiz
        {
            if(!viewControllerQuiz.selectedAnswer.isAnswered){
                return false
            }
        }
            return true
    }
    
    
    func submitAnswersAndTransitionToTabBar(){
        var selectedAnswers = [SelectedAnswer]()
        for viewControllerQuiz in viewControllersQuiz
        {
            selectedAnswers.append(viewControllerQuiz.selectedAnswer)
        }
        user.postQuestions(selectedAnswers) { (json, error) in
            if (error == nil)
            {
                self.user.detetermineCharacter(selectedAnswers)
                self.user.postCharacter(self.user.character)
                let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
                let tabBarController : TabBarController = storyboard.instantiateViewControllerWithIdentifier("TabBarController") as! TabBarController
                tabBarController.user = self.user
                self.presentViewController(tabBarController, animated: true, completion: nil)
            }
            else
            {
                print(error?.localizedDescription)
            }
        }
    }
}


 extension PageViewControllerQuiz:UIPageViewControllerDataSource{
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController)  else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        return orderedViewControllers[previousIndex]
    }
    
    
    func pageViewController(pageViewController: UIPageViewController,viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController)
        else
        {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        guard orderedViewControllersCount != nextIndex
        else
        {
            return nil
        }
        guard orderedViewControllersCount > nextIndex
        else
        {
            return nil
        }
        return orderedViewControllers[nextIndex]
    }
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,firstViewControllerIndex = orderedViewControllers.indexOf(firstViewController)
        else
        {
                return 0
        }
        return firstViewControllerIndex
    }
    
    
}