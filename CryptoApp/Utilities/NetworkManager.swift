//
//  NetworkManager.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 1/26/25.
//

import Foundation

class NetworkManager{
    private init(){}
    
    static func getRequest<T:Codable>(url : URL, type : T.Type) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["accept": "application/json",
                                       "x-cg-demo-api-key": "CG-3FRyPRKnHmiCnFpcgVWbXB6E"
        ]
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decoderResult = try decoder.decode(T.self, from: data)
        return decoderResult
    }
    
    static func request(url : URL ) async throws -> Data {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["accept": "application/json",
                                       "x-cg-demo-api-key": "CG-3FRyPRKnHmiCnFpcgVWbXB6E"]
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
}
