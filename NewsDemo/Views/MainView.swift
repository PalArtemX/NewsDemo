//
//  MainView.swift
//  NewsDemo
//
//  Created by Artem Paliutin on 27/06/2022.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            // MARK: - NewsTabView
            NewsTabView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            
            // MARK: - BookmarkTabView
            BookmarkTabView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
        }
    }
}










struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ArticleNewsVM())
            .environmentObject(ArticleBookmarkVM())
    }
}
