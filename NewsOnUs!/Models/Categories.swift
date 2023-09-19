//
//  Categories.swift
//  NewsOnUs!
//
//  Created by Yaşar Ebru İmrahor on 15.09.2023.
//

import Foundation


enum Categories: String, CaseIterable {
    case general = "General"
    case business = "Business"
    case entertainment = "Entertainment"
    case health = "Health"
    case science = "Science"
    case sports = "Sports"
    case technology = "Technology"
    
    
    var categoryName: String {
        switch self {
        case.general:
            return "general"
        case.business:
            return "business"
        case.entertainment:
            return "entertainment"
        case.health:
            return "health"
        case.science:
            return "science"
        case.sports:
            return "sports"
        case.technology:
            return "technology"
        }
    }
    
    var imageName: String {
        switch self {
        case.general:
            return "general"
        case.business:
            return "business"
        case.entertainment:
            return "entertainment"
        case.health:
            return "health"
        case.science:
            return "science"
        case.sports:
            return "sports"
        case.technology:
            return "technology"
        }
    }
    
}
