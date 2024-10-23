//
//  Survey+State.swift
//  Xm-survey
//
//  Created by Veljko Bogdanovic on 23.10.24..
//

import Foundation
import ComposableArchitecture

public extension Survey {
    
    @ObservableState
    struct State: Equatable {
        var loadingState: LoadingState = .uninitialized
        
        var questions: [Question] = []
        var currentQuestionIndex: Int = 0
    }
}


public enum LoadingState: Equatable {
    case uninitialized
    case loading
    case failed
    case finished
}
