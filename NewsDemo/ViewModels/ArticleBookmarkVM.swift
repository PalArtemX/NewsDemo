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
    }
    
    // MARK: removeBookmark
    func removeBookmark(for article: Article) {
        guard let index = bookmarks.firstIndex(where: { $0.id == article.id }) else {
            return
        }
        
        bookmarks.remove(at: index)
    }
    
}


