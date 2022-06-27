//
//  ArticleListView.swift
//  NewsDemo
//
//  Created by Artem Paliutin on 27/06/2022.
//

import SwiftUI

struct ArticleListView: View {
    let articles: [Article]
    @State private var selectedArticle: Article?
    
    var body: some View {
        List {
            ForEach(articles) { article in
                ArticleRowView(article: article)
                    .onTapGesture {
                        selectedArticle = article
                    }
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .sheet(item: $selectedArticle) {
            SafariView(url: $0.articleURL)
                .ignoresSafeArea()
        }
    }
}










struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView(articles: ArticlePreview.articles)
    }
}
