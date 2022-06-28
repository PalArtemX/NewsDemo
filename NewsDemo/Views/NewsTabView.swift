//
//  NewsTabView.swift
//  NewsDemo
//
//  Created by Artem Paliutin on 27/06/2022.
//

import SwiftUI

struct NewsTabView: View {
    @EnvironmentObject var articleNewsVM: ArticleNewsVM
    private var articles: [Article] {
        if case let .success(articles) = articleNewsVM.phase {
            return articles
        }  else {
            return []
        }
    }
    
    var body: some View {
        NavigationStack {
            ArticleListView(articles: articles)
                .overlay(overlayView)
                .task(id: articleNewsVM.fetchTaskToken) {
                    await loadTask()
                }
                .refreshable {
                    refreshTask()
                }
                .navigationTitle(articleNewsVM.fetchTaskToken.category.text)
                .toolbar {
                    menu
                }
        }
    }
}










struct NewsTabView_Previews: PreviewProvider {
    static var previews: some View {
        NewsTabView()
            .environmentObject(ArticleNewsVM(articles: ArticlePreview.articles, selectedCategory: .general))
            .environmentObject(ArticleBookmarkVM())
    }
}





// MARK: - Extension NewsTabView
extension NewsTabView {
    // MARK: overlayView
    private var overlayView: some View {
        Group {
            switch articleNewsVM.phase {
            case .empty:
                ProgressView()
            case .success(let articles) where articles.isEmpty:
                EmptyPlaceholderView(text: "No Articles", image: nil)
            case .failure(let error):
                RetryView(text: error.localizedDescription) {
                   refreshTask()
                }
            default:
                EmptyView()
            }
        }
    }
    
    // MARK: menu
    private var menu: some View {
        Menu {
            Picker("Category", selection: $articleNewsVM.fetchTaskToken.category) {
                ForEach(Category.allCases) {
                    Text($0.text)
                        .tag($0)
                }
            }
        } label: {
            Image(systemName: "fiberchannel")
                .symbolRenderingMode(.hierarchical)
                .imageScale(.large)
        }

    }
    
    // MARK: loadTask()
    private func loadTask() async {
        await articleNewsVM.loadArticles()
    }
    
    // MARK:
    private func refreshTask() {
        articleNewsVM.fetchTaskToken = FetchTaskToken(category: articleNewsVM.fetchTaskToken.category, token: Date())
    }
    
}
