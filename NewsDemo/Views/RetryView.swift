//
//  RetryView.swift
//  NewsDemo
//
//  Created by Artem Paliutin on 27/06/2022.
//

import SwiftUI

struct RetryView: View {
    let text: String
    let retryAction: () -> ()
    
    var body: some View {
        VStack(spacing: 8.0) {
            Text(text)
                .font(.callout)
            
            Button {
                retryAction()
            } label: {
                Label("Try Again", systemImage: "goforward")
            }
            .buttonStyle(.bordered)

        }
    }
}










struct RetryView_Previews: PreviewProvider {
    static var previews: some View {
        RetryView(text: "Retry", retryAction: {})
    }
}
