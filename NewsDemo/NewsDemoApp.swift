//
//  NewsDemoApp.swift
//  NewsDemo
//
//  Created by Artem Paliutin on 24/06/2022.
//

import SwiftUI

@main
struct NewsDemoApp: App {
    @StateObject var articleNewVM = ArticleNewsVM()
    @StateObject var articleBookmarkVM = ArticleBookmarkVM.shared
    @StateObject var articleSearchVM = ArticleSearchVM()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(articleNewVM)
                .environmentObject(articleBookmarkVM)
                .environmentObject(articleSearchVM)
        }
    }
}
