//
//  SurveyClient.swift
//  Xm-survey
//
//  Created by Veljko Bogdanovic on 23.10.24..
//

import Foundation
import ComposableArchitecture

public struct SurveyClient {
    var fetchQuestions: @Sendable () async throws -> [Question]
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

public enum NetworkError: Error, Equatable {
    case serverError
}

extension SurveyClient {
    static let mainUrl = "https://xm-assignment.web.app"
    
    static let live = SurveyClient(
        fetchQuestions: {
            let url = URL(string: mainUrl + "/questions")!
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([Question].self, from: data)
        },
        mainQueue: DispatchQueue.main.eraseToAnyScheduler()
    )
}
