//
//  DataFetchPhase.swift
//  NewsDemo
//
//  Created by Artem Paliutin on 27/06/2022.
//

import Foundation

enum DataFetchPhase<T> {
    case empty
    case success(T)
    case failure(Error)
}
