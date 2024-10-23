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
    
    public var body: some ReducerOf<Self> {
        
        Reduce { state, action in
            switch action {
            
            default:
                return .none
            }
        }
    }
}
