//
//  ArticleRowView.swift
//  NewsDemo
//
//  Created by Artem Paliutin on 25/06/2022.
//

import SwiftUI

struct ArticleRowView: View {
    let article: Article
    @EnvironmentObject var articleBookmarkVM: ArticleBookmarkVM
    
    var body: some View {
        VStack(spacing: 16.0) {
            // MARK: - Image
            AsyncImage(url: article.imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    Image(systemName: "photo")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                @unknown default:
                    fatalError()
                }
            }
            .frame(minHeight: 200, maxHeight: 300)
            .padding(.vertical)
            .clipped()
            
            // MARK: - Text
            VStack(spacing: 6.0) {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(3)

                
                Text(article.descriptionText)
                    .font(.subheadline)
                    .lineLimit(2)
                
                HStack {
                    Text(article.captionText)
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    // MARK: - Bookmark Button
                    Button {
                        toggleBookmark(for: article)
                    } label: {
                        Image(systemName: articleBookmarkVM.isBookmarked(for: article) ? "bookmark.fill" : "bookmark")
                    }
                    .buttonStyle(.bordered)
                    
                    
                    // MARK: - Share Button
                    Button {
                        presentShareSheet(url: article.articleURL)
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .buttonStyle(.bordered)

                }
                .padding(.vertical)
            }
            .padding()
        }
    }
}










struct ArticleRowView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRowView(article: ArticlePreview.articles[0])
            .environmentObject(ArticleBookmarkVM())
    }
}





// MARK: - Extension ArticleRowView
extension ArticleRowView {
    private func toggleBookmark(for article: Article) {
        if articleBookmarkVM.isBookmarked(for: article) {
            articleBookmarkVM.removeBookmark(for: article)
        } else {
            articleBookmarkVM.addBookmark(for: article)
        }
    }
}
