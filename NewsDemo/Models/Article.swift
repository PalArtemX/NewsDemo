//
//  Article.swift
//  NewsDemo
//
//  Created by Artem Paliutin on 24/06/2022.
//

import Foundation

fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()


struct Article {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: Date
    
    
    var authorText: String {
        author ?? ""
    }
    var descriptionText: String {
        description ?? ""
    }
    var captionText: String {
        "\(source.name) ⋅ \(relativeDateFormatter.localizedString(for: publishedAt, relativeTo: Date()))"
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

extension Article: Identifiable {
    var id: String { url }
}
