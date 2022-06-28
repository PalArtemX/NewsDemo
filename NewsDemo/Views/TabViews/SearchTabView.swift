//
//  SearchTabView.swift
//  NewsDemo
//
//  Created by Artem Paliutin on 28/06/2022.
//

import SwiftUI

struct SearchTabView: View {
    @EnvironmentObject var articleSearchVM: ArticleSearchVM
    
    
    var body: some View {
        NavigationStack {
            ArticleListView(articles: articles)
                .overlay {
                    overlayView
                }
                
                .navigationTitle("Search")
        }
        .searchable(text: $articleSearchVM.searchQuery) {
            suggestionsView
        }
        .onChange(of: articleSearchVM.searchQuery) { newValue in
            if newValue.isEmpty {
                articleSearchVM.phase = .empty
            }
        }
        .onSubmit(of: .search) {
            search()
        }
    }
}










struct SearchTabView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTabView()
            .environmentObject(ArticleSearchVM())
    }
}



// MARK: - Extension SearchTabView
extension SearchTabView {
    // MARK: articles
    private var articles: [Article] {
        if case .success(let articles) = articleSearchVM.phase {
            return articles
        } else {
            return []
        }
    }
    
    // MARK: overlayView
    @ViewBuilder
    private var overlayView: some View {
        switch articleSearchVM.phase {
        case .empty:
            if !articleSearchVM.searchQuery.isEmpty {
                ProgressView()
            } else {
                EmptyPlaceholderView(text: "Type your query to search from NewsAPI", image: Image(systemName: "magnifyingglass"))
            }
            
        case .success(let articles) where articles.isEmpty:
            EmptyPlaceholderView(text: "No search results found", image: Image(systemName: "magnifyingglass"))
            
        case .failure(let error):
            RetryView(text: error.localizedDescription) {
                search()
            }
            
        default: EmptyView()
        }
    }
    
    // MARK: search()
    private func search() {
        Task {
            await articleSearchVM.searchArticle()
        }
    }
    
    // MARK: suggestionsView
    @ViewBuilder
    private var suggestionsView: some View {
        ForEach(["Swift", "Covid-19", "BTC", "iOS 16"], id: \.self) { text in
            Button {
                articleSearchVM.searchQuery = text
            } label: {
                Text(text)
                    .foregroundColor(.gray)
            }

        }
    }
}
