//
//  BusinessViewModel.swift
//  NewsOnUs!
//
//  Created by Yaşar Ebru İmrahor on 14.09.2023.
//

import Foundation

class CategoryViewModel {
    
    var categoryNews: AllCategoryModel?
    var dataModel: [New]?
    
    
    func getCategoryData(category: String, complete: @escaping (Bool)->()) {
        APIService.getCategoryData(category:category) { categoryNews in
            guard let categoryNews = categoryNews else { complete(false); return }
            self.categoryNews = categoryNews
            complete(true)
        }
    }
    
    
    func getSearchData(query: String, complete: @escaping (Bool)->()) {
        APIService.getSearchData(query: query) { categoryNews in
            guard let categoryNews = categoryNews else { complete(false); return }
            self.categoryNews = categoryNews
            complete(true)
        }
    }
    


    func getCountData() -> Int {
        guard let articles = categoryNews?.articles else { return 0 }
        return articles.count
    }
    
    
    func getCategoryModel(at indexPath: IndexPath) -> New {
        guard let articles = categoryNews?.articles else { return New(source: nil, author: "", title: "", description: "", url: "", urlToImage: "", publishedAt: "", content: "") }
        return articles[indexPath.row]
    }
}
