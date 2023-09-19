//
//  APIService.swift
//  NewsOnUs!
//
//  Created by Yaşar Ebru İmrahor on 13.09.2023.
//

import Foundation
import Alamofire

class APIService {
    
    static let shared = APIService()
    
    let rootUrlCategory = "https://newsapi.org/v2/top-headlines"
    let rootUrlEverything = "https://newsapi.org/v2/everything"
    let apiKey = "c365faa353f84bd4be90c8060d406396"
    let topHeadlines = "?country=us&apiKey="

    
    static func getCategoryData(category: String, completion: @escaping (AllCategoryModel?) -> ()) {
        guard let url = URL(string: "\(shared.rootUrlCategory)?country=us&category=\(category)&apiKey=\(shared.apiKey)") else { return }
        AF.request(url, method: .get).responseJSON { response in
                switch response.result {
                case .success(let data):
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: data)
                        let decodedData = try JSONDecoder().decode(AllCategoryModel.self, from: jsonData)
                        completion(decodedData)
                    } catch {
                        print("Error: Data could not be converted to the specified format! Change the .decode type in the decodedData variable.")
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
    
    
    static func getSearchData(query: String,completion: @escaping (AllCategoryModel?) -> ()) {
        guard let url = URL(string: "\(shared.rootUrlEverything)?q=\(query)&apiKey=\(shared.apiKey)") else { return }
        AF.request(url, method: .get).responseJSON { response in
                switch response.result {
                case .success(let data):
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: data)
                        let decodedData = try JSONDecoder().decode(AllCategoryModel.self, from: jsonData)
                        completion(decodedData)
                    } catch {
                        print("Error: Data could not be converted to the specified format! Change the .decode type in the decodedData variable.")
                    }
                case .failure(let error):
                    print("Hata: \(error.localizedDescription)")
                }
            }
    }
    
}
