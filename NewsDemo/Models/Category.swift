//
//  Category.swift
//  NewsDemo
//
//  Created by Artem Paliutin on 27/06/2022.
//

import Foundation

enum Category: String, CaseIterable, Identifiable {
    var id: Self {
        self
    }
    
    case general
    case business
    case technology
    case entertainment
    case sports
    case science
    case health
    
    var text: String {
        if self == .general {
            return "Top Headlines"
        }
        return rawValue.capitalized
    }
}
