//
//  Survey+Action.swift
//  Xm-survey
//
//  Created by Veljko Bogdanovic on 23.10.24..
//

import Foundation
import ComposableArchitecture

public extension Survey {
    
    enum Action: BindableAction {
        case startSurvey
        case loadQuestions(Result<[Question], NetworkError>)
        case nextQuestion
        case previousQuestion
        case submitAnswer(Int, String)
        case submissionResponse(Result<Void, NetworkError>)
        case binding(BindingAction<State>)
    }
}
