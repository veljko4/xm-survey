//
//  Survey+Model.swift
//  Xm-survey
//
//  Created by Veljko Bogdanovic on 23.10.24..
//

import Foundation
import SwiftUI

public struct Question: Equatable, Identifiable, Codable {
    public let id: Int
    let question: String?
    var answer: String?
    var submitted: Bool?
}

struct QuestionWrapper {
    var question: Question
        
    // Binding that handles the optional
    var answerBinding: Binding<String> {
        Binding<String>(
            get: { question.answer ?? "" },
            set: { newValue in
                var updatedQuestion = question
                updatedQuestion.answer = newValue.isEmpty ? "" : newValue
            }
        )
    }
}
