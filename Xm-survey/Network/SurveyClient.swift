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
    var submitAnswer: @Sendable (Question) async throws -> ()
}

extension SurveyClient {
    static let mainUrl = "https://xm-assignment.web.app"
    
    static func productionEnvironment(using networkService: NetworkService = DefaultNetworkService()) -> SurveyClient {
        return SurveyClient(
            fetchQuestions: {
                let url = URL(string: mainUrl + "/questions")!
                return try await networkService.getRequest(url: url)
            },
            submitAnswer: { answer in
                let url = URL(string: mainUrl + "/question/submit")!
                try await networkService.postRequest(url: url, body: answer)
            }
        )
    }
}
