//
//  NewsAPIResponse.swift
//  NewsDemo
//
//  Created by Artem Paliutin on 24/06/2022.
//

import Foundation


struct NewsAPIResponse: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
    
    let code: String?
    let message: String?
    
    
}
