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
                .onAppear {
                    Task {
                        await articleNewsVM.loadArticles()
                    }
                }
                .navigationTitle(articleNewsVM.selectedCategory.text)
        }
    }
}










struct NewsTabView_Previews: PreviewProvider {
    static var previews: some View {
        NewsTabView()
            .environmentObject(ArticleNewsVM(articles: ArticlePreview.articles, selectedCategory: .general))
            
    }
}
