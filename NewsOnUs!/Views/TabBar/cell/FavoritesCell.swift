//
//  FavoritesCell.swift
//  NewsOnUs!
//
//  Created by Yaşar Ebru İmrahor on 12.09.2023.
//

import UIKit

class FavoritesCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!        
    @IBOutlet weak var newsImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: New) {
        //guard let title = model.title, let desc = model.description, let imgUrl = model.urlToImage else { return }
        titleLabel.text = model.title ?? ""
        descriptionLabel.text = model.description ?? ""
        guard let imgUrl = model.urlToImage else { newsImage.image = UIImage(named: "News"); return }
        let url = URL(string: imgUrl)
        newsImage.kf.setImage(with: url)
    }

}
