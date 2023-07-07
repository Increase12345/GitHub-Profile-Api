//
//  Service.swift
//  GitHub
//
//  Created by Nick Pavlov on 7/6/23.
//

import Foundation

// Service function
struct Service {
    
    func fetchData<T: Codable>(with urlPath: String) async throws -> T {
        guard let url = URL(string: urlPath) else { fatalError() }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(T.self, from: data)
    }
}
