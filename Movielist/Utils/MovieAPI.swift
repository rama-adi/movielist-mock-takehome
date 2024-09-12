//
//  MovieAPI.swift
//  Movielist
//
//  Created by Rama Adi Nugraha on 11/09/24.
//

import Foundation
struct AirtableConfig {
    let baseURL: String
    let appID: String
    let token: String
    let tableID: String
    
    init(baseURL: String, appID: String, token: String, tableID: String) {
        self.baseURL = baseURL
        self.appID = appID
        self.token = token
        self.tableID = tableID
    }
    
    static let `default` = AirtableConfig(
        baseURL: "https://api.airtable.com/v0",
        appID: "appuBwbfPaNRThH6c",
        token: "",
        tableID: "tbl4QbZkvFeZckcDy"
    )
}

enum MovieAPIError: Error {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
}

// MARK: - API Client
actor MovieAPI {
    let config: AirtableConfig
    let session: URLSession
    
    init(config: AirtableConfig = .default, session: URLSession = .shared) {
        self.config = config
        self.session = session
    }
    
    // GET https://api.airtable.com/v0/{baseId}/{tableIdOrName}
    func listMovies(limit: Int? = nil, offset: String? = nil) async throws -> MovieRecordResponse {
        var components = URLComponents(string: "\(config.baseURL)/\(config.appID)/\(config.tableID)")
        
        guard let url = components?.url else {
            throw MovieAPIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(config.token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await session.data(for: request)
            let decoder = JSONDecoder()
            let movieRecord = try decoder.decode(MovieRecordResponse.self, from: data)
            return movieRecord
        } catch let decodingError as DecodingError {
            throw MovieAPIError.decodingError(decodingError)
        } catch {
            throw MovieAPIError.networkError(error)
        }
    }
}
