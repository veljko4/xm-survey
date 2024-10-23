//
//  NetworkService.swift
//  Xm-survey
//
//  Created by Veljko Bogdanovic on 23.10.24..
//

import Foundation

public protocol NetworkService {
    func getRequest<T: Decodable>(url: URL) async throws -> T
    func postRequest<T: Encodable>(url: URL, body: T) async throws -> ()
}

public enum NetworkError: Error, Equatable {
    case serverError
}

public struct DefaultNetworkService: NetworkService {
    public init() {}
    
    public func getRequest<T: Decodable>(url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    public func postRequest<T: Encodable>(url: URL, body: T) async throws -> () {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(body)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.serverError
        }
    }
}
