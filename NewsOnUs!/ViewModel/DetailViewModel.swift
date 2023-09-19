//
//  DetailViewModel.swift
//  NewsOnUs!
//
//  Created by Yaşar Ebru İmrahor on 16.09.2023.
//

import Foundation


class DetailViewModel{
    
    var formattedDate: String?
    var new = New()
    
    init(model: New) {
        self.new.urlToImage = model.urlToImage
        self.new.title = model.title
        self.new.publishedAt = model.publishedAt
        self.new.author = model.author
        self.new.description = model.description
        self.new.url = model.url
    }
    
    
    func editedDateString(publishedAt: String?) -> String {
        guard let editDate = publishedAt else { return "Date is not found!" }
        return changeDataFormat(date: editDate)
    }
    
    
    func changeDataFormat(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let inputDate = dateFormatter.date(from: date)

        if let inputDate = inputDate {
            dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
            let formattedDate = dateFormatter.string(from: inputDate)
            return formattedDate
        } else {
            return date
        }
    }
    
}
