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
                        Text("Welcome")
                            .padding(.top, 16)
                            .frame(maxWidth: .infinity, alignment: .top)
                        Spacer()
                        Button("Start survey") {
                            store.questions.removeAll()
                            store.send(.startSurvey)
                        }
                        Spacer()
                    }
                    .frame(maxHeight: .infinity)
                    
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
                SurveyScreenView(store: store)
            }
        }
    }
}

#Preview {
    InitialScreenView(store: .init(initialState: Survey.State()) {
        Survey()
    })
}
