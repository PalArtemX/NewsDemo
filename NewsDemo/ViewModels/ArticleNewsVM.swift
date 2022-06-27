//
//  ArticleNewsViewModel.swift
//  NewsDemo
//
//  Created by Artem Paliutin on 27/06/2022.
//

import Foundation

@MainActor
class ArticleNewsVM: ObservableObject {
    @Published var phase = DataFetchPhase<[Article]>.empty
    @Published var fetchTaskToken: FetchTaskToken
    private let newAPI = NewsAPI.shared
    
    // MARK: - init
    init(articles: [Article]? = nil, selectedCategory: Category = .general) {
        if let articles = articles {
            phase = .success(articles)
        } else {
            phase = .empty
        }
        self.fetchTaskToken = FetchTaskToken(category: selectedCategory, token: Date())
    }
    
    
    // MARK: - Functions
    // MARK: loadArticles
    func loadArticles() async {
        if Task.isCancelled { return }
        phase = .empty
        
        do {
            let articles = try await newAPI.fetch(from: fetchTaskToken.category)
            if Task.isCancelled { return }
            phase = .success(articles)
        } catch {
            if Task.isCancelled { return }
            print("⚠️ Error: loadArticles() \(error.localizedDescription)")
            print(String(describing: error))
            phase = .failure(error)
        }
    }
}
