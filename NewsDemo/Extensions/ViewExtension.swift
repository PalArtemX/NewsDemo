//
//  ViewExtension.swift
//  NewsDemo
//
//  Created by Artem Paliutin on 27/06/2022.
//

import SwiftUI


extension View {
    func presentShareSheet(url: URL) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .keyWindow?
            .rootViewController?
            .present(activityVC, animated: true)
    }
}
