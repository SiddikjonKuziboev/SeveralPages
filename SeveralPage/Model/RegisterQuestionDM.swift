//
//  RegisterQuestionDM.swift
//  SeveralPage
//
//  Created by Kuziboev Siddikjon on 24/09/23.
//

import Foundation

struct SubAnswer: Codable {
    var answer_text: String
    var isSelected: Bool
    var question_text: String?
    var sub_answers: [String]?
}

struct Answer: Codable {
    var answer_text: String
    var isSelected: Bool
    var question_text: String?
    var sub_answers: [SubAnswer]?
}

struct CustomQuestion: Codable {
    var question: String
    var answers: [Answer]
}

extension CustomQuestion {
    
    static func questions() -> [CustomQuestion] {
        if let url = Bundle.main.url(forResource: "RegisterQuestions", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let customQuestions = try JSONDecoder().decode([CustomQuestion].self, from: data)
                return customQuestions
            } catch {
                print("Error loading data: \(error)")
            }
        }
        return []
    }
}
