//
//  BookmarkTabView.swift
//  NewsDemo
//
//  Created by Artem Paliutin on 28/06/2022.
//

import SwiftUI

struct BookmarkTabView: View {
    @EnvironmentObject var articleBookmarkVM: ArticleBookmarkVM
    
    var body: some View {
        NavigationStack {
            ArticleListView(articles: articleBookmarkVM.bookmarks)
                .overlay {
                    overlayView(isEmpty: articleBookmarkVM.bookmarks.isEmpty)
                }
            
                .navigationTitle("Saved Articles")
        }
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
}
