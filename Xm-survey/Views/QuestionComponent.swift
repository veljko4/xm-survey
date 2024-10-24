//
//  QuestionComponent.swift
//  Xm-survey
//
//  Created by Veljko Bogdanovic on 23.10.24..
//

import SwiftUI
import ComposableArchitecture

public struct QuestionComponent: View {
    @Bindable private var store: StoreOf<Survey>
    
    private let questionIndex: Int
    
    @State private var answer: String = ""
    
    @State private var showBanner: Bool = false
    @State private var bannerMessage: String = ""
    @State private var bannerColor: Color = .clear
    
    public init(store: StoreOf<Survey>, questionIndex: Int) {
        _store = Bindable(store)
        self.questionIndex = questionIndex
    }
    
    public var body: some View {
        
        let isAnswerSubmitted = store.questions[questionIndex].submitted ?? false
        
        VStack {
            Text(store.questions[questionIndex].question ?? "")
                .padding(.vertical, 16)
            
            TextField("Type here for an answer...", text: $answer)
                .padding(.vertical, 8)
                .padding(.horizontal)
                .autocorrectionDisabled()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: isAnswerSubmitted ? 0 : 1)
                )
                .foregroundColor(isAnswerSubmitted ? .gray : .black)
                .multilineTextAlignment(.center)
                .padding(.bottom, 32)
                .disabled(showBanner || isAnswerSubmitted)
            
            if !showBanner {
                Button(isAnswerSubmitted ? "Already submitted" : "Submit") {
                    store.send(.submitAnswer(questionIndex, store.questions[questionIndex].answer ?? ""))
                }
                .disabled(isAnswerSubmitted || showBanner || answer.isEmpty)
            }
            
            if showBanner {
                buildNotification(text: bannerMessage, backgroundColor: bannerColor)
            }
        }
        .onChange(of: store.loadingState) { _, newValue in
            
            if newValue == .failed {
                bannerMessage = "Failure! Please retry."
                bannerColor = .red
            } else if newValue == .finished {
                bannerMessage = "Success"
                bannerColor = .green
            } else {
                bannerMessage = ""
                bannerColor = .clear
            }
            
            showBanner = true
            
            Task {
                try? await Task.sleep(for: .seconds(1.5))
                showBanner = false
                store.loadingState = .uninitialized
            }
        }
        .onChange(of: store.questions[questionIndex].answer ?? "") { _, newValue in
            answer = newValue
        }
    }
    
    @ViewBuilder func buildNotification(text: String, backgroundColor: Color) -> some View {
        Text(text)
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .foregroundColor(.white)
    }
}
