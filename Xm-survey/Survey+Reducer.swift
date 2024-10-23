//
//  Survey+Reducer.swift
//  Xm-survey
//
//  Created by Veljko Bogdanovic on 23.10.24..
//

import Foundation
import ComposableArchitecture

@Reducer
public struct Survey {
    let client = SurveyClient.liveEnvironment
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .startSurvey:
                state.loadingState = .loading
                
                return .run { send in
                    do {
                        let questions = try await client.fetchQuestions()
                        await send(.loadQuestions(.success(questions)))
                    } catch {
                        await send(.loadQuestions(.failure(.serverError)))
                    }
                }
                
            case let .loadQuestions(.success(questions)):
                state.questions = questions
                state.loadingState = .finished
                return .none
                
            case .loadQuestions(.failure):
                state.loadingState = .failed
                return .none
                
            case .nextQuestion:
                state.currentQuestionIndex = min(state.currentQuestionIndex + 1, state.questions.count - 1)
                return .none
                
            case .previousQuestion:
                state.currentQuestionIndex = max(state.currentQuestionIndex - 1, 0)
                return .none
                
            case let .submitAnswer(index, answer):
                state.loadingState = .loading
                state.questions[index].answer = answer
                
                let question = state.questions[index]
                return .run { send in
                    do {
                        try await client.submitAnswer(question)
                        await send(.submissionResponse(.success(())))
                    } catch {
                        await send(.submissionResponse(.failure(.serverError)))
                    }
                }
                
            case .submissionResponse(.success):
                let index = state.currentQuestionIndex
                state.questions[index].submitted = true
                state.loadingState = .finished
                return .none
                
            case .submissionResponse(.failure):
                state.loadingState = .failed
                return .none
                
            default:
                return .none
            }
        }
    }
}
