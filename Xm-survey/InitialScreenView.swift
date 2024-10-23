//
//  InitialScreenView.swift
//  Xm-survey
//
//  Created by Veljko Bogdanovic on 23.10.24..
//

import SwiftUI
import ComposableArchitecture

struct InitialScreenView: View {
    
    private let store: StoreOf<Survey>
    
    @State private var shouldNavigate = false
    
    public init(store: StoreOf<Survey>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack {
            ZStack {
                if store.loadingState != .loading {
                    VStack {
                        Button("Start survey") {
                            store.questions.removeAll()
                            store.send(.startSurvey)
                        }
                    }
                    
                } else {
                    ProgressView("Please wait..")
                }
            }
            .onChange(of: store.loadingState) { _, newValue in
                if newValue == .finished {
                    if !store.questions.isEmpty {
                        shouldNavigate = true
                    }
                }
            }
            .navigationDestination(isPresented: $shouldNavigate) {
                SurveyScreen(store: store)
            }
        }
    }
}
