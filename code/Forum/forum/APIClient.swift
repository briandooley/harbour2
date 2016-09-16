//
//  APIClient.swift
//  forum
//
//  Created by Sipan Calli on 25/07/16.
//  Copyright © 2016 FeedHenry. All rights reserved.
//

import Foundation
import FeedHenry
import SwiftyJSON


class APIClient{
    
    private let header = ["Content-Type":"application/json"]
    
    
    func postCharacter(character:String, completion:(json:JSON,error:NSError?) ->()) {
        
        FH.cloud("/profile/characther", method: HTTPMethod.POST, args: [:], headers:header)
        {(resp:Response, responseError:NSError?) in
            
            if let unwrappedRawResponse = resp.rawResponse
            {
                do
                {
                    let trueJson = try NSJSONSerialization.JSONObjectWithData(unwrappedRawResponse, options: NSJSONReadingOptions.AllowFragments)
                    completion(json:JSON(trueJson),error: responseError)
                }
                catch
                {
                    completion( json: nil, error: responseError)
                }
            }
            else
            {
                completion( json: nil, error: responseError)
            }
        }
    }

    
    
    func getQuestions(completion:(json:JSON,error:NSError?) ->()) {
        
        FH.cloud("/questions", method: HTTPMethod.GET, args: [:], headers:header)
        {(resp:Response, responseError:NSError?) in
            
            if let unwrappedRawResponse = resp.rawResponse
            {
                do
                {
                let trueJson = try NSJSONSerialization.JSONObjectWithData(unwrappedRawResponse, options: NSJSONReadingOptions.AllowFragments)
                    completion(json:JSON(trueJson),error: responseError)
                }
                catch
                {
                    completion( json: nil, error: responseError)
                }
            }
            else
            {
                completion( json: nil, error: responseError)
            }
        }
    }
    
    
    func postQuestions(userId:String, selectedAnswers:[SelectedAnswer], completion:(json:JSON,error:NSError?) ->()){
        var questionsArray = [[String : AnyObject]]()
        for selectedAnswer in selectedAnswers{
            var answer : [String:String]
            var question : [String:AnyObject]
            if let unwrappedValue = selectedAnswer.answer?.value{
                if let unwrappedText = selectedAnswer.answer?.text{
                    if let unwrappedQuestionID = selectedAnswer.questionId{
                        answer = ["value":unwrappedValue,"text":unwrappedText]
                        question = ["questionId":unwrappedQuestionID, "answer":answer]
                        questionsArray.append(question )
                    }
                }
            }
        }
        
        let arg : [String:AnyObject]
        arg = ["userId":userId,"questions":questionsArray]
        
        FH.cloud("/profile/questions", method: HTTPMethod.POST, args: arg , headers: header)
        {(resp:Response, responseError:NSError?) in
            
            if let unwrappedRawResponse = resp.rawResponse
            {
                do
                {
                    let trueJson = try NSJSONSerialization.JSONObjectWithData(unwrappedRawResponse, options: NSJSONReadingOptions.AllowFragments)
                    completion(json:JSON(trueJson),error: responseError)
                }
                catch
                {
                    completion( json: nil, error: responseError)
                }
            }
            else
            {
                completion( json: nil, error: responseError)
            }
        }
    }
    
    
    func postMission(userId: String, missionId:String, missionPoints:String,completion:(json:JSON,error:NSError?) ->()){
        let arg : [String:AnyObject]
         arg = ["userId":userId,"missionId":missionId,"points":missionPoints]
        
        FH.cloud("/profile/completeMission", method: HTTPMethod.POST, args: arg , headers: header)
        {(resp:Response, responseError:NSError?) in
            if let unwrappedRawResponse = resp.rawResponse
            {
                do
                {
                    let trueJson = try NSJSONSerialization.JSONObjectWithData(unwrappedRawResponse, options: NSJSONReadingOptions.AllowFragments)
                    completion(json:JSON(trueJson),error: responseError)
                }
                catch
                {
                    completion( json: nil, error: responseError)
                }
            }
            else
            {
                completion( json: nil, error: responseError)
            }
        }
    }
    
    
    func getCreateProfile(userId:String,completion:(json:JSON,error:NSError?) ->()){
        FH.cloud("/profile", method: HTTPMethod.GET, args: ["userId":userId], headers: header)
        {(resp:Response, responseError:NSError?) in
            
            if let unwrappedRawResponse = resp.rawResponse
            {
                do
                {
                    let trueJson = try NSJSONSerialization.JSONObjectWithData(unwrappedRawResponse, options: NSJSONReadingOptions.AllowFragments)
                    completion(json:JSON(trueJson),error: responseError)
                }
                catch
                {
                    completion( json: nil, error: responseError)
                }
            }
            else
            {
                completion( json: nil, error: responseError)
            }
        }
    }
    
    
    func getMissions(completion:(json:JSON,error:NSError?) ->()){
        FH.cloud("/missions", method: HTTPMethod.GET, args: [:], headers: header)
        {(resp:Response, responseError:NSError?) in
            
            if let unwrappedRawResponse = resp.rawResponse
            {
                do
                {
                    let trueJson = try NSJSONSerialization.JSONObjectWithData(unwrappedRawResponse, options: NSJSONReadingOptions.AllowFragments)
                    completion(json:JSON(trueJson),error: responseError)
                }
                catch
                {
                    completion( json: nil, error: responseError)
                }
            }
            else
            {
                completion( json: nil, error: responseError)
            }
        }
    }
    
    
    func getAgenda(userId:String,completion:(json:JSON,error:NSError?) ->()){
        FH.cloud("/agenda", method: HTTPMethod.POST, args: ["userId":userId], headers: header)
        {(resp:Response, responseError:NSError?) in
            
            if let unwrappedRawResponse = resp.rawResponse
            {
                do
                {
                    let trueJson = try NSJSONSerialization.JSONObjectWithData(unwrappedRawResponse, options: NSJSONReadingOptions.AllowFragments)
                    completion(json:JSON(trueJson),error: responseError)
                }
                catch
                {
                    completion( json: nil, error: responseError)
                }
            }
            else
            {
                completion( json: nil, error: responseError)
            }
        }
    }
}


