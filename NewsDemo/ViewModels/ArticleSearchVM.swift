//
//  ArticleSearchVM.swift
//  NewsDemo
//
//  Created by Artem Paliutin on 28/06/2022.
//

import Foundation

@MainActor
class ArticleSearchVM: ObservableObject {
    @Published var phase: DataFetchPhase<[Article]> = .empty
    @Published var searchQuery = ""
    private let newsAPI = NewsAPI.shared
    
    
    // MARK: - Functions
    // MARK: searchArticle
    func searchArticle() async {
        if Task.isCancelled { return }
        
        let searchQuery = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        phase = .empty
        
        if searchQuery.isEmpty {
            return
        }
        
        do {
            let article = try await newsAPI.search(for: searchQuery)
            if Task.isCancelled { return }
            phase = .success(article)
        } catch {
            phase = .failure(error)
        }
    }
    
}
