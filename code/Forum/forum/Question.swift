//
//  QuestionsAndAnswers.swift
//  forum
//
//  Created by Sipan Calli on 25/07/16.
//  Copyright © 2016 FeedHenry. All rights reserved.
//

/// Class for modelling the question get/post from the API.
class Question{
    var question:String?
    var questionId:Int?
    var answers = [Answer?]()
}