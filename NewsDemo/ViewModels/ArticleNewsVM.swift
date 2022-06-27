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
    @Published var selectedCategory: Category
    private let newAPI = NewsAPI.shared
    
    // MARK: - init
    init(articles: [Article]? = nil, selectedCategory: Category) {
        if let articles = articles {
            phase = .success(articles)
        } else {
            phase = .empty
        }
        self.selectedCategory = selectedCategory
    }
    
    
    // MARK: - Functions
    // MARK: loadArticles
    func loadArticles() async {
        phase = .empty
        
        do {
            let articles = try await newAPI.fetch(from: selectedCategory)
            phase = .success(articles)
        } catch {
            phase = .failure(error)
        }
    }
}
