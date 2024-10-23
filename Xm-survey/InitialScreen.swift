//
//  InitialScreen.swift
//  Xm-survey
//
//  Created by Veljko Bogdanovic on 23.10.24..
//

import SwiftUI
import ComposableArchitecture

struct InitialScreen: View {
    
    private let store: StoreOf<Survey>
        
    public init(store: StoreOf<Survey>) {
        self.store = store
    }
    
    public var body: some View {
        ZStack {}
    }
}
