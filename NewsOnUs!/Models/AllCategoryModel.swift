//
//  BusinessModel.swift
//  NewsOnUs!
//
//  Created by Yaşar Ebru İmrahor on 14.09.2023.
//

import Foundation

struct AllCategoryModel: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [New]?
}

// MARK: - Article
struct New: Codable, Equatable {
    var source: SourceAll?
    var author, title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    
    var isFavorite: Bool? {
        return FavoriteManager.shared.isFavorite(self)
    }
}

// MARK: - Source
struct SourceAll: Codable, Equatable {
    var id: String?
    var name: String?
}
