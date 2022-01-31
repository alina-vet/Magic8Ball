//
//  AnswerSettings.swift
//  Magic8Ball
//
//  Created by Алина Бондарчук on 28.01.2022.
//

import Foundation
import UIKit

var answerModel = ["Maybe yes maybe no", "In the next life", "Now unknown", "As I see it, yes", "Outlook good", "Yes", "Reply hazy, try again", "Ask again later", "Better not tell you now", "Concentrate and ask again", "Don't count on it", "My reply is no"]

func addData(nameAnswer: String) {
    answerModel.append(nameAnswer)
    saveData()
}

func removeAnswer(at index: Int) {
    answerModel.remove(at: index)
    saveData()
}

func saveData() {
    UserDefaults.standard.set(answerModel, forKey: "answerDataKey")
    UserDefaults.standard.synchronize()
}

func loadData() {
    if let array = UserDefaults.standard.array(forKey: "answerDataKey") as? [String] {
        answerModel = array
    } else {
        answerModel
    }
}

func moveItem(fromIndex: Int, toIndex: Int) {
    let from = answerModel[fromIndex]
    answerModel.remove(at: fromIndex)
    answerModel.insert(from, at: toIndex)
}
