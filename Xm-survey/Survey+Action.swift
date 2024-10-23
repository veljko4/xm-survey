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
        case nextQuestion
        case previousQuestion
        case binding(BindingAction<State>)
    }
}
