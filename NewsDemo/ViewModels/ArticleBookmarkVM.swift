//
//  ArticleBookmarkVM.swift
//  NewsDemo
//
//  Created by Artem Paliutin on 28/06/2022.
//

import Foundation


@MainActor
class ArticleBookmarkVM: ObservableObject {
    @Published private(set) var bookmarks: [Article] = []
    private let bookmarkStore = PlistDataStore<[Article]>(filename: "bookmark")
    
    static let shared = ArticleBookmarkVM()
    private init() {
        Task {
            await bookmarkStore.load()
        }
    }
    
    
    // MARK: - Functions
    // MARK: isBookmarked
    func isBookmarked(for article: Article) -> Bool {
        bookmarks.first { article.id == $0.id } != nil
    }
    
    // MARK: addBookmark
    func addBookmark(for article: Article) {
        guard !isBookmarked(for: article) else {
            return
        }
        
        bookmarks.insert(article, at: 0)
        bookmarkUpdated()
    }
    
    // MARK: removeBookmark
    func removeBookmark(for article: Article) {
        guard let index = bookmarks.firstIndex(where: { $0.id == article.id }) else {
            return
        }
        
        bookmarks.remove(at: index)
        bookmarkUpdated()
    }
    
    // MARK: bookmarkUpdated
    private func bookmarkUpdated() {
        let bookmarks = bookmarks
        
        Task {
            await bookmarkStore.save(bookmarks)
        }
    }
    
}


