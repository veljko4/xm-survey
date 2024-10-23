//
//  SurveyScreenView.swift
//  Xm-survey
//
//  Created by Veljko Bogdanovic on 23.10.24..
//

import SwiftUI
import ComposableArchitecture

struct SurveyScreenView: View {
    @Bindable private var store: StoreOf<Survey>
    
    public init(store: StoreOf<Survey>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            HStack {
                Text("Question: \(store.currentQuestionIndex + 1) / \(store.questions.count)")
                
                Spacer()
                
                Button("Previous") {
                    store.send(.previousQuestion)
                }
                .padding(.trailing, 16)
                .disabled(store.isFirstQuestion)
                
                Button("Next") {
                    store.send(.nextQuestion)
                }
                .disabled(store.isLastQuestion)
            }
            .padding(.bottom, 64)
            
            Text("Questions submitted: \(store.submittedQuestionsCount)")
            
            TabView(selection: $store.currentQuestionIndex) {
                ForEach(store.questions.indices, id: \.self) { index in
                    QuestionComponent(store: store, questionIndex: index)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            
            Spacer()
        }
        .padding(32)
    }
}

#Preview {
    SurveyScreenView(store: .init(initialState: Survey.State()) {
        Survey()
    })
}
