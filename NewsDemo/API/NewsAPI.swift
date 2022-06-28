//
//  NewsAPI.swift
//  NewsDemo
//
//  Created by Artem Paliutin on 27/06/2022.
//

import Foundation


struct NewsAPI {
    static let shared = NewsAPI()
    private init() {}
    
    private let apiKey = "9eeacb21127e40dd9c562650be8c2751"
    private let session = URLSession.shared
    
    // FIXME: .iso8601
//    private let decoder: JSONDecoder = {
//        let decoder = JSONDecoder()
//        decoder.dataDecodingStrategy = .iso8601
//    }()
    let decoder = JSONDecoder()
    
    
    func fetch(from category: Category) async throws -> [Article] {
        try await fetchArticles(from: generateNewsURL(from: category))

        
    }
    
    func search(for query: String) async throws -> [Article] {
        try await fetchArticles(from: generateSearchURL(from: query))
    }
    
    
    private func generateError(code: Int = 1, description: String) -> Error {
        NSError(domain: "NewsAPI", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
    
    
    private func generateNewsURL(from category: Category) -> URL {
        var url = "https://newapi.org/v2/top-headlines?"
        url += "apiKey=\(apiKey)"
        url += "&language=en"
        url += "&category=\(category.rawValue)"
        return URL(string: url)!
    }
    
    private func generateSearchURL(from query: String) -> URL {
        let percentEncodedString = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        
        var url = "https://newapi.org/v2/everything?"
        url += "apiKey=\(apiKey)"
        url += "&language=en"
        url += "&q=\(percentEncodedString)"
        
        return URL(string: url)!
    }
    
    private func fetchArticles(from url: URL) async throws -> [Article] {
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            print("⚠️ BAD RESPONSE")
            throw generateError(description: "Bad Response")
        }
        
        switch response.statusCode {
        case (200...299), (400...499):
            let apiResponse = try decoder.decode(NewsAPIResponse.self, from: data)
            if apiResponse.status == "ok" {
                return apiResponse.articles
            } else {
                throw generateError(description: apiResponse.message ?? "An error occured")
            }
        default:
            throw generateError(description: "A server error occured")
        }
    }
}
