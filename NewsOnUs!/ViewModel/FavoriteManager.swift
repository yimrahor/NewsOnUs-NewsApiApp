//
//  FavoriteManager.swift
//  NewsOnUs!
//
//  Created by Yaşar Ebru İmrahor on 17.09.2023.
//

import Foundation
import Firebase

class FavoriteManager {
    static var shared = FavoriteManager()
    
    let encoder = JSONEncoder()
    var favNews: [New] = []
    
    
    init() {
        startAction()
    }
    
    
    func startAction() {
        guard let favEmail = Auth.auth().currentUser else { return }
        if let data = UserDefaults.standard.data(forKey: "Favorites-\(favEmail.uid)") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                // Decode 
                favNews = try decoder.decode([New].self, from: data)
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
    }
    

    func isFavorite(_ news: New) -> Bool {
        return favNews.contains(where: { $0 == news })
    }

    
    func deleteNews(_ news: New) {
        guard let favEmail = Auth.auth().currentUser else { return }
        guard let index =  favNews.firstIndex(of: news) else { return }
        favNews.remove(at: index)
        do {
            let data = try encoder.encode(favNews)
            
            UserDefaults.standard.set(data, forKey: "Favorites-\(favEmail.uid)")
        } catch { return }
    }
    

    func addFavorite(_ news: New) {
        favNews.append(news)
        do {
            let data = try encoder.encode(favNews)
            guard let favEmail = Auth.auth().currentUser else { return }
            
            UserDefaults.standard.set(data, forKey: "Favorites-\(favEmail.uid)")

        } catch { return }
    }

}

