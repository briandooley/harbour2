//
//  User.swift
//  forum
//
//  Created by Sipan Calli on 27/07/16.
//  Copyright © 2016 FeedHenry. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
    
    var userId : String?
    var selectedAnswers = [SelectedAnswer]()
    var isUserLoggedIn:Bool = true
    var completedMissionIds = [Int64?]()
    var character : String = ""
    var score : Int64?
    var questionsArray = [Question]()
    var masterArray = [Master]()
    var agendaString : String?
 
    
    func cloudCallAgenda(completion:()->()){
        let apiClient = APIClient()
        
        if let unwrappedUserId = userId{
            apiClient.getAgenda(unwrappedUserId) { (json, error) in
                if let error = error
                {
                    print("Cloud Call Failed, \(error)")
                    return
                }
                self.agendaString = json["image"].string
                completion()
            }
        }
    }

    
    func cloudCallQuestions(completion:()->()) {
        let apiClient = APIClient()
        apiClient.getQuestions { (json, error) in
            if let error = error
            {
                print("Cloud Call Failed, \(error)")
                return
            }
            self.sortJsonQuestions(json)
            completion()
        }
    }
    
    
    func cloudCallMaster(completion:()->()) {
        let apiClient = APIClient()
        apiClient.getMissions{ (json, error) in
            if let error = error
            {
                print("Cloud Call Failed, \(error)")
                return
            }
            self.sortJsonMaster(json)
            completion()
        }
    }
    
           //MARK: Private functions
    
   private func sortJsonQuestions(json:JSON){
        for (_,subJson):(String,JSON) in json
        {
            let question = Question()
            question.question = subJson["question"].string
            question.questionId = subJson["questionId"].int
            for (_,subJson):(String,JSON) in subJson["answers"]
            {
                let answer = Answer()
                answer.value = subJson["value"].string
                answer.text = subJson["text"].string
                question.answers.append(answer)
            }
            questionsArray.append(question)
        }
    }
    
    
   private func sortJsonMaster(json:JSON){
        
        for (_,subJson):(String,JSON) in json
        {
            let master = Master()
            master.missionId = subJson["missionId"].int64
            master.mission = subJson["mission"].string
            master.desc = subJson["desc"].string
            master.point = subJson["points"].int64
            masterArray.append(master)
        }
    }

    
    /**
     Function determines character for the user based on selected answers.
     
     - parameter selectedAnswers: <#selectedAnswers description#>
     */
    func detetermineCharacter(selectedAnswers:[SelectedAnswer]){
        var first: Int = 0
        var second: Int = 0
        var third: Int = 0
        var fourth: Int = 0
        for selectedAnswer in selectedAnswers{
            if let unwrappedSelectedAnswerNumber = selectedAnswer.answer?.number{
                if (unwrappedSelectedAnswerNumber == 0){
                    first += 1
                }else if (unwrappedSelectedAnswerNumber == 1){
                    second += 1
                }else if (unwrappedSelectedAnswerNumber == 2){
                    third += 1
                }else if (unwrappedSelectedAnswerNumber == 3){
                    fourth += 1
                }
            }
        }
        let intDictionary = ["first":first, "second":second, "third":third, "fourth":fourth]
        
        func biggestNumber(one:Int, two:Int) -> Bool {
            if(one>two){
                return true
            }
            return false
        }
        

        var biggestMember:(String,Int) = intDictionary.first!
        for dictionaryMember in intDictionary {
            if dictionaryMember == intDictionary.first!{
                biggestMember = dictionaryMember
            }
            else if (!biggestNumber(biggestMember.1, two: dictionaryMember.1)){
                biggestMember = dictionaryMember
            }
        }
        
        if (biggestMember.0 == "first"){
            character = "rockstar"
        }else if (biggestMember.0 == "second"){
            character = "public speaker"
        }else if (biggestMember.0 == "third"){
            character = "yoga guru"
        }else if (biggestMember.0 == "fourth"){
            character = "nobel prize winner"
        }
    }
    
 
    func postCharacter(character:String){
        let myAPI = APIClient()
        myAPI.postCharacter(character) { (json, error) in
            self.character = character
        }
    }
    
    
    func postQuestions(selectedAnswers:[SelectedAnswer],completion:(json:JSON,error:NSError?) ->()){
        let myAPI = APIClient()
        myAPI.postQuestions(userId!, selectedAnswers: selectedAnswers) { (json, error) in
            completion(json: json, error: error)
            self.selectedAnswers = selectedAnswers
            
        }
    }
    
    
    func updateCompletedMissions(missionId : Int64,missionPoint: Int64, completion:(json:JSON,error:NSError?) ->()){
        let myAPI = APIClient()
        let stringMissionId = String(missionId)
        let stringMissionPoints = String(missionPoint)
        myAPI.postMission(userId!, missionId: stringMissionId, missionPoints: stringMissionPoints, completion: { (json, error) in
            self.score = json["score"].int64
            let completeMissions = json["completeMissions"]
            self.completedMissionIds.removeAll()
            let endIndex = completeMissions.count
            for index in 0...endIndex
            {
                if let unwrappedMissionId = completeMissions[index].int64
                {
                    self.completedMissionIds.append(unwrappedMissionId)
                }
                else{
                    if let unwrappedMissionId = completeMissions[index].string{
                        let intUnwrapped = Int64(unwrappedMissionId)
                        self.completedMissionIds.append(intUnwrapped)
                    }
                }
            }
            self.score = json["score"].int64
            completion(json: json, error: error)
        })
    }
    
    
    func getCreateProfile(userId:String, completion:(json:JSON,error:NSError?) ->()){
        let myAPI = APIClient()
        myAPI.getCreateProfile(userId) {(json, error) in
            if let unwrappedJsonUserId = json["userId"].string
            {
                self.userId = unwrappedJsonUserId
            }
            let completeMissions = json["completeMissions"]
            let endIndex = completeMissions.count
            for index in 0...endIndex
            {
                if let unwrappedMissionId = completeMissions[index].int64
                {
                    self.completedMissionIds.append(unwrappedMissionId)
                }
                else
                {
                    if let unwrappedMissionId = completeMissions[index].string
                    {
                        let int = Int64(unwrappedMissionId)
                        if let unwrappedInt = int
                        {
                            self.completedMissionIds.append(unwrappedInt)

                        }
                    }
                }
            }
            self.score = json["score"].int64
            completion(json: json, error: error)
        }
    }

    
    func populateUserFromDefaults(){
        let defaults = NSUserDefaults.standardUserDefaults()
        userId = defaults.valueForKey("userId") as? String
        isUserLoggedIn = defaults.boolForKey("isUserLoggedIn")
    }
    
    
    /**
     Logs in user
          */
    func loginUser()  {
        let defaults = NSUserDefaults.standardUserDefaults()
        isUserLoggedIn = true
        defaults.setBool(isUserLoggedIn, forKey: "isUserLoggedIn")
        defaults.setValue(userId, forKey: "userId")
        defaults.synchronize()
    }
    
    
    /**
     Logs out user.
     */
    func logOutUser() {
        userId = nil
        isUserLoggedIn = false
        
        for key in Array(NSUserDefaults.standardUserDefaults().dictionaryRepresentation().keys) {
            NSUserDefaults.standardUserDefaults().removeObjectForKey(key)
        }
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.synchronize()
    }
    
}


