//
//  SurveyScreen.swift
//  Xm-survey
//
//  Created by Veljko Bogdanovic on 23.10.24..
//

import SwiftUI
import ComposableArchitecture

struct SurveyScreen: View {
    @Bindable private var store: StoreOf<Survey>
    
    public init(store: StoreOf<Survey>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            HStack {
                Text("Questions submitted: \(store.submittedQuestionsCount)")
                
                Spacer()
                
                Button("Previous") {
                    store.send(.previousQuestion)
                }
                .disabled(store.isFirstQuestion)
                
                Button("Next") {
                    store.send(.nextQuestion)
                }
                .disabled(store.isLastQuestion)
            }
            
            TabView(selection: $store.currentQuestionIndex) {
                ForEach(store.questions.indices, id: \.self) { index in
                    QuestionView(store: store, questionIndex: index)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
        }
        .padding(32)
    }
}
