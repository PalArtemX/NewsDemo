//
//  SearchHistoryListView.swift
//  NewsDemo
//
//  Created by Artem Paliutin on 28/06/2022.
//

import SwiftUI

struct SearchHistoryListView: View {
    @EnvironmentObject var articleSearchVM: ArticleSearchVM
    let onSubmit: (String) -> ()
    
    var body: some View {
        List {
            HStack {
                Text("Recently Searched")
                Spacer()
                
                Button("Clear") {
                    articleSearchVM.removeAllHistory()
                }
            }
            .listRowSeparator(.hidden)
            
            ForEach(articleSearchVM.history, id: \.self) { history in
                Button(history) {
                    onSubmit(history)
                }
                .swipeActions(content: {
                    Button(role: .destructive) {
                        articleSearchVM.removeHistory(history)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }

                })
                .foregroundColor(.gray)
            }
        }
        .listStyle(.plain)
    }
}










struct SearchHistoryListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchHistoryListView(onSubmit: {_ in })
            .environmentObject(ArticleSearchVM())
    }
}
