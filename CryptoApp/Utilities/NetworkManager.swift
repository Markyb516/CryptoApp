//
//  NetworkManager.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 1/26/25.
//

import Foundation

final class NetworkManager : Sendable{
    private init(){}
    
    static private let apiKey = ProcessInfo.processInfo.environment["API_Key"]
    
    static func getRequest<T:Codable>(url : URL, type : T.Type) async throws -> T {
        guard let apiKey else { throw EnvironmentError.missingKey}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["accept": "application/json",
                                       "x-cg-demo-api-key": apiKey
        ]
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decoderResult = try decoder.decode(T.self, from: data)
        
        return decoderResult
    }
    
    static func request(url : URL ) async throws -> Data {
        guard let apiKey else { throw EnvironmentError.missingKey}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["accept": "application/json",
                                       "x-cg-demo-api-key": apiKey]
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
    
    
}

enum EnvironmentError : LocalizedError{
    case missingKey
    var errorDescription: String?{
        switch self {
        case .missingKey:
            return "key not found"
        }
    }
    
   
}
