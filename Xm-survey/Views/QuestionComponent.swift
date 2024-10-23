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
    
    @State private var showBanner: Bool = false
    @State private var bannerMessage: String = ""
    @State private var bannerColor: Color = .clear
    
    public init(store: StoreOf<Survey>, questionIndex: Int) {
        _store = Bindable(store)
        self.questionIndex = questionIndex
    }
    
    public var body: some View {
        VStack {
            Text(store.questions[questionIndex].question ?? "")
                .padding(.vertical, 16)
            
            let wrapper = QuestionWrapper(question: store.questions[questionIndex])
            TextField("Type your answer...", text: wrapper.answerBinding)
                .padding(.vertical, 8)
                .padding(.horizontal)
                .autocorrectionDisabled()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.bottom, 32)
            
            if !showBanner {
                let isAnswerSubmitted = store.questions[questionIndex].submitted ?? false
                Button(isAnswerSubmitted ? "Already submitted" : "Submit") {
                    store.send(.submitAnswer(questionIndex, store.questions[questionIndex].answer ?? ""))
                }
                .disabled(isAnswerSubmitted || showBanner)
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
    }
    
    @ViewBuilder func buildNotification(text: String, backgroundColor: Color) -> some View {
        Text(text)
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .foregroundColor(.white)
    }
}
