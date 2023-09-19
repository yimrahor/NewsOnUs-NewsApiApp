//
//  DetailViewController.swift
//  NewsOnUs!
//
//  Created by Yaşar Ebru İmrahor on 12.09.2023.
//

import UIKit
import Kingfisher
import SafariServices

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentView: UITextView!
    @IBOutlet weak var sourButton: UIButton!
    
    var favButton: UIBarButtonItem?
    var detailViewModel: DetailViewModel?
    
    var news: New? { didSet {
        configureView()
    }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        news = detailViewModel?.new
        guard let news = news else { return }
        titleLabel.text = news.title
        
        let publishedAt = detailViewModel?.editedDateString(publishedAt: news.publishedAt)
        dateLabel.text = publishedAt
        
        authorLabel.text = news.author
        contentView.text = news.description
        guard let imgUrl = news.urlToImage else { newsImage.image = UIImage(named: "News"); return }
        let url = URL(string: imgUrl)
        newsImage.kf.indicatorType = .activity
        newsImage.kf.setImage(with: url)
    }
    
    
    func configureView() {
        favButton = UIBarButtonItem(image: UIImage(named: news?.isFavorite == true ? "fav" : "unFav"), style: .done, target: self, action: #selector(favTapped))
        let shareButton = UIBarButtonItem(image: UIImage(named: "share"), style: .done, target: self, action: #selector(shareTapped))
        navigationItem.rightBarButtonItems = [favButton!, shareButton]
    }
    
    @objc func favTapped(sender: UIBarButtonItem) {
        guard let news = news else { return }
        guard let isFavorite = news.isFavorite else { return }
        if isFavorite {
            FavoriteManager.shared.deleteNews(news)
        } else {
            FavoriteManager.shared.addFavorite(news)
        }
        favButton?.image = UIImage(named: !isFavorite ? "fav" : "unFav")
    }
    
    @objc func shareTapped() {
        let activityVC =  UIActivityViewController(activityItems: [news?.url], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true)
    }
    
    @IBAction func sourceButtonTapped(_ sender: Any) {
        guard let url = URL(string: news!.url ?? "") else { return }
        let vc = SFSafariViewController(url: url)
        self.present(vc, animated: true)
    }
    
}
