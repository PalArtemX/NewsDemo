//
//  Article.swift
//  NewsDemo
//
//  Created by Artem Paliutin on 24/06/2022.
//

import Foundation


struct Article {
    let source: Source
    let title: String
    let url: String
    let publishedAt: Date
    let author: String?
    let description: String?
    let urlToImage: String?
    
    var authorText: String {
        author ?? ""
    }
    var descriptionText: String {
        description ?? ""
    }
    var articleURL: URL {
        URL(string: url)!
    }
    var imageURL: URL? {
        guard let urlToImage = urlToImage else {
            return nil
        }
        return URL(string: urlToImage)
    }
    
    struct Source: Codable, Equatable {
        let name: String
    }
}


extension Article: Codable {
    
}

extension Article: Equatable {
    
}

extension Article {
    static var previewData: [Article] {
        let previewDataURL = Bundle.main.url(forResource: "news", withExtension: "json")!
        let data = try! Data(contentsOf: previewDataURL)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dataDecodingStrategy = .deferredToData
        
        let apiResponse = try! jsonDecoder.decode(NewsAPIResponse.self, from: data)
        return apiResponse.articles 
    }
}

extension Article: Identifiable {
    var id: String { url }
}
