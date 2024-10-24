//
//  Xm_surveyTests.swift
//  Xm-surveyTests
//
//  Created by Veljko Bogdanovic on 23.10.24..
//

import ComposableArchitecture
import Testing
@testable import Xm_survey

@MainActor
struct Xm_surveyTests {
    
    // Given
    let store = TestStore(initialState: Survey.State()) {
        Survey()
    }
    
    @Test("Starting survey should load questions")
    func testStartSurveySuccess() async {
        store.exhaustivity = .off
        
        // When
        await store.send(.startSurvey) {
            // Then
            $0.loadingState = .loading
        }
        
        // When
        await store.send(.loadQuestions(.success([Question(id: 1, question: "What's your favorite color?")]))) {
            // Then
            $0.loadingState = .finished
            $0.questions = [
                Question(id: 1, question: "What's your favorite color?")
            ]
        }
    }
    
    @Test("Starting survey should fail")
    func testStartSurveyFailure() async {
        store.exhaustivity = .off
        
        await store.send(.startSurvey) {
            $0.loadingState = .loading
        }
        
        await store.send(.loadQuestions(.failure(.serverError))) {
            $0.loadingState = .failed
        }
    }
    
    @Test("Should load questions and submit answer")
    func testSubmitAnswerSuccess() async {
        store.exhaustivity = .off
        
        await store.send(.loadQuestions(.success([Question(id: 1, question: "What's your favorite color?")]))) {
            $0.loadingState = .finished
            $0.questions = [
                Question(id: 1, question: "What's your favorite color?")
            ]
        }
        
        await store.send(.submitAnswer(0, "Blue")) {
            $0.loadingState = .loading
            $0.questions[0].answer = "Blue"
        }
        
        await store.send(.submissionResponse(.success(()))) {
            $0.loadingState = .finished
            $0.questions[0].submitted = true
        }
    }
    
    @Test("Should load questions and fail")
    func testSubmitAnswerFailure() async {
        store.exhaustivity = .off
        
        await store.send(.loadQuestions(.success([Question(id: 1, question: "What's your favorite color?")]))) {
            $0.loadingState = .finished
            $0.questions = [
                Question(id: 1, question: "What's your favorite color?")
            ]
        }
        
        await store.send(.submitAnswer(0, "Red")) {
            $0.loadingState = .loading
            $0.questions[0].answer = "Red"
        }
        
        await store.send(.submissionResponse(.failure(.serverError))) {
            $0.loadingState = .failed
        }
    }
}
