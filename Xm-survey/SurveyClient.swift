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
    var submitAnswer: @Sendable (Question) async throws -> Void
}

public enum NetworkError: Error, Equatable {
    case serverError
}

extension SurveyClient {
    static let mainUrl = "https://xm-assignment.web.app"
    
    static let liveEnvironment = SurveyClient(
        fetchQuestions: {
            let url = URL(string: mainUrl + "/questions")!
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([Question].self, from: data)
        },
        submitAnswer: { answer in
            var request = URLRequest(url: URL(string: mainUrl + "/question/submit")!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(answer)

            let (_, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkError.serverError
            }
        }
    )
}
