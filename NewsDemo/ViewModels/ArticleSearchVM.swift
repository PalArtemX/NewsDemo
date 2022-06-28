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
    @Published var history: [String] = []
    
    private let historyMaxLimit = 10
    private let newsAPI = NewsAPI.shared
    
    
    // MARK: - Functions
    // MARK: searchArticle()
    func searchArticle() async {
        if Task.isCancelled { return }
        
        let searchQuery = self.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        phase = .empty
        
        if searchQuery.isEmpty {
            return
        }
        
        do {
            let article = try await newsAPI.search(for: searchQuery)
            if Task.isCancelled { return }
            
            if searchQuery != self.searchQuery {
                return
            }
            
            phase = .success(article)
        } catch {
            phase = .failure(error)
        }
    }
    
    // MARK: addHistory()
    func addHistory(_ text: String) {
        if let index = history.firstIndex(where: { text.lowercased() == $0.lowercased() }) {
            history.remove(at: index)
        } else if history.count == historyMaxLimit {
            history.remove(at: 0)
        }
        
        history.insert(text, at: 0)
    }
    
    // MARK: removeHistory()
    func removeHistory(_ text: String) {
        guard let index = history.firstIndex(where: { text.lowercased() == $0.lowercased() }) else {
           return
        }
        history.remove(at: index)
    }

    // MARK: removeAllHistory()
    func removeAllHistory() {
        history.removeAll()
    }
    
}
