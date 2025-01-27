//
//  NetworkManager.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 1/26/25.
//

import Foundation

class NetworkManager{
    static var instance = NetworkManager()
    private init(){}
    
    func getRequest<T:Codable>(url : URL, type : T.Type) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["accept": "application/json"]
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decoderResult = try decoder.decode(T.self, from: data)
        return decoderResult
          
        
    }
}
