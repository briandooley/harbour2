

import UIKit
import FeedHenry
import SwiftyJSON
import Eureka

class ViewControllerQuiz: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Mark: Properties
    
    var isLast:Bool = false
    var question = Question()
    var pageViewControllerDelegate : PageViewControllerQuiz?
    var pageIndex:Int?
    var selectedAnswer = SelectedAnswer()


    
    //MARK: Outlets
    
    @IBOutlet weak var tableViewAnswers: UITableView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelQuestion: UILabel!
    
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTitle.textColor = UIColor.redHatDarkRed()
        tableViewAnswers.delegate = self
        tableViewAnswers.dataSource = self
        tableViewAnswers.registerNib(UINib(nibName:"TableViewCell",bundle: nil ), forCellReuseIdentifier: "cellAnswer")
        labelQuestion.text = question.question
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: Private functions
    
    
    private func presentTabBarController(){
        let tabBarController = TabBarController()
        presentViewController(tabBarController, animated: true, completion: nil)
    }
    
    
    //MARK: TableView Delegate and Datasource functions
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell : TableViewCell = tableView.dequeueReusableCellWithIdentifier("cellAnswer") as! TableViewCell
        if let unwrappedQuestionText = question.answers[indexPath.section]?.text{
            cell.labelTitle.text = unwrappedQuestionText
        }
        return cell
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return question.answers.count
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor.clearColor()
        return header
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedAnswer.questionId = question.questionId
        selectedAnswer.answer = question.answers[indexPath.section]
        selectedAnswer.answer?.number = indexPath.section
        selectedAnswer.isAnswered = true

        if (isLast)
        {
            let refreshAlert = UIAlertController(title: "Submit?", message: "Do you want to submit your answers", preferredStyle: UIAlertControllerStyle.Alert)
            refreshAlert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction!) in
                
                if let unwrappedPageViewControllerDelegate = self.pageViewControllerDelegate{
                    if (unwrappedPageViewControllerDelegate.hasAllQuestionsBeenAnswered()){
                        unwrappedPageViewControllerDelegate.submitAnswersAndTransitionToTabBar()
                    }
                    else{
                        let alertMessage = UIAlertController(title: "Not all questions have been answered", message: "All questions in the quizz must be answered", preferredStyle: UIAlertControllerStyle.Alert)
                        alertMessage.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
                        self.presentViewController(alertMessage, animated: true, completion: nil)
                        self.tableViewAnswers.reloadData()
                    }
                }
                            }))
            refreshAlert.addAction(UIAlertAction(title: "No", style: .Cancel, handler: nil))
            presentViewController(refreshAlert, animated: true, completion: nil)
        }
    }
}