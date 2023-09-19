//
//  FavoritesNewsViewController.swift
//  NewsOnUs!
//
//  Created by Yaşar Ebru İmrahor on 9.09.2023.
//

import UIKit

class FavoritesNewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        FavoriteManager.shared.startAction()
    }
    
    func configureView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
        
}

//MARK: UITableView
extension FavoritesNewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        FavoriteManager.shared.favNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell", for: indexPath) as? FavoritesCell else { return UITableViewCell() }
        cell.configure(model: FavoriteManager.shared.favNews[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "DetailViewController") as? DetailViewController {
        let object = DetailViewModel(model: FavoriteManager.shared.favNews[indexPath.row])
        vc.detailViewModel = object
        navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
}
