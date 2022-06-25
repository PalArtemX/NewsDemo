//
//  ArticlePreview.swift
//  NewsDemo
//
//  Created by Artem Paliutin on 25/06/2022.
//

import Foundation


struct ArticlePreview {
    static var articles: [Article] {
        let previewDataURL = Bundle.main.url(forResource: "news", withExtension: "json")!
        let data = try! Data(contentsOf: previewDataURL)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dataDecodingStrategy = .deferredToData
        
        let apiResponse = try! jsonDecoder.decode(NewsAPIResponse.self, from: data)
        return apiResponse.articles
    }
    
    static let article = Article(
        source: Article.Source(name: "ESPN"),
        author: "David Purdum",
        title: "With an Avalanche win, and $34K on the line, this bettor is on the verge of prognostication glory",
        description: "In 2021, Tanner Flynn picked the winners of the Super Bowl, World Series, Stanley Cup and NBA Finals. He's about to do it again while adding college football to the mix. With $34,000 and prognostication glory on the line, Flynn is sweating over the Cup.",
        url: "https://www.espn.com/nhl/story/_/id/34138026/2022-stanley-cup-final-bettor-sweating-colorado-avalanche-second-parlay-predicting-super-bowl-stanley-cup-nba-finals-winners",
        urlToImage: "https://a3.espncdn.com/combiner/i?img=%2Fphoto%2F2022%2F0623%2Fr1028322_480x480_1%2D1.jpg",
        publishedAt: Date())
}
