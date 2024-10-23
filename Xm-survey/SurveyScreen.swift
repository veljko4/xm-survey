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
                Text("Questions submitted: ")
                
                Spacer()
                
                Button("Previous") {
                    store.send(.previousQuestion)
                }
                
                Button("Next") {
                    store.send(.nextQuestion)
                }
            }
            
            TabView(selection: $store.currentQuestionIndex) {

            }
            .tabViewStyle(PageTabViewStyle())
        }
        .padding(32)
    }
}
