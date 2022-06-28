//
//  BookmarkTabView.swift
//  NewsDemo
//
//  Created by Artem Paliutin on 28/06/2022.
//

import SwiftUI

struct BookmarkTabView: View {
    @EnvironmentObject var articleBookmarkVM: ArticleBookmarkVM
    @State var searchText = ""
    
    var body: some View {
        let articles = articles
        
        NavigationStack {
            ArticleListView(articles: articles)
                .overlay {
                    overlayView(isEmpty: articles.isEmpty)
                }
            
                .navigationTitle("Saved Articles")
        }
        .searchable(text: $searchText)
    }
}










struct BookmarkTabView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkTabView()
            .environmentObject(ArticleBookmarkVM.shared)
    }
}



// MARK: Extension BookmarkTabView
extension BookmarkTabView {
    @ViewBuilder
    private func overlayView(isEmpty: Bool) -> some View {
        if isEmpty {
            EmptyPlaceholderView(text: "No Saved Articles", image: Image(systemName: "bookmark"))
        }
    }
    
    private var articles: [Article] {
        if searchText.isEmpty {
            return articleBookmarkVM.bookmarks
        }
        return articleBookmarkVM.bookmarks
            .filter {
                $0.title.lowercased().contains(searchText.lowercased()) ||
                $0.descriptionText.lowercased().contains(searchText.lowercased())
            }
    }
}
