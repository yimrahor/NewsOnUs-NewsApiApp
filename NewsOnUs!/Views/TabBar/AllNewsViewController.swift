//
//  AllNewsViewController.swift
//  NewsOnUs!
//
//  Created by Yaşar Ebru İmrahor on 10.09.2023.
//

import UIKit

class AllNewsViewController: UIViewController, SideMenuViewControllerDelegate {
    
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var backViewForSide: UIView!
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var leadingConstraintForSideView: NSLayoutConstraint!
    
    let viewModel = CategoryViewModel()
    
    var categories: String = ""
    var makeSearch = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        if categories == "" {
            navigationItem.title = "GENERAL NEWS"
        } else {
            navigationItem.title = "\(categories.uppercased())"
        }
    }
          
    
    override func viewWillAppear(_ animated: Bool) {
        if makeSearch == false {
            initVM()
        }
    }

    
    func initVM() {
        viewModel.getCategoryData(category: categories) { value in
            if value {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print(self.viewModel.categoryNews)
            }
        }

    }
    
    
    func configureView(){
        backViewForSide.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    
    
    //MARK: SideMenu
    var sideViewController : SideMenuViewController?
    private var isSideMenuShown:Bool = false
    private var beginPoint:CGFloat = 0.0
    private var difference:CGFloat = 0.0
    
    @IBAction func tappedOnSideBackView(_ sender: Any) {
        self.hideSideView()
    }
    
    func hideSideMenu() {
        self.hideSideView()
    }
    
    private func hideSideView() {
        UIView.animate(withDuration: 0.1) {
            self.leadingConstraintForSideView.constant = 10
            self.view.layoutIfNeeded()
        } completion: { (status) in
            self.backViewForSide.alpha = 0.0
            UIView.animate(withDuration: 0.1) {
                self.leadingConstraintForSideView.constant = -280
                self.view.layoutIfNeeded()
            } completion: { (status) in
                self.backViewForSide.isHidden = true
                self.isSideMenuShown = false
            }
        }
    }

    @IBAction func showSideMenu(_ sender: Any) {
        if isSideMenuShown == false {
            UIView.animate(withDuration: 0.1) {
                self.leadingConstraintForSideView.constant = 10
                self.view.layoutIfNeeded()
            } completion: { (status) in
                self.backViewForSide.alpha = 0.75
                self.backViewForSide.isHidden = false
                UIView.animate(withDuration: 0.1) {
                    self.leadingConstraintForSideView.constant = 0
                    self.view.layoutIfNeeded()
                } completion: { (status) in
                    self.isSideMenuShown = true
                    }
                }
            sideMenuBtn.tintColor = .white
            self.backViewForSide.isHidden = false
        } else {
            sideMenuBtn.tintColor = #colorLiteral(red: 0.8684186339, green: 0.8584913611, blue: 0.8543596268, alpha: 1)
            self.hideSideView()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "sideSegue")
        {
            if let controller = segue.destination as? SideMenuViewController
            {
                self.sideViewController = controller
                self.sideViewController?.delegate = self
            }
        }
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (isSideMenuShown) {
             if let touch = touches.first {
                let location = touch.location(in: backViewForSide)
                beginPoint = location.x
                sideMenuBtn.tintColor = #colorLiteral(red: 0.8684186339, green: 0.8584913611, blue: 0.8543596268, alpha: 1)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (isSideMenuShown) {
            if let touch = touches.first {
                let location = touch.location(in: backViewForSide)
                let differenceFromBeginPoint = beginPoint - location.x
                if (differenceFromBeginPoint>0 || differenceFromBeginPoint<280) {
                    difference = differenceFromBeginPoint
                    self.leadingConstraintForSideView.constant = -differenceFromBeginPoint
                    self.backViewForSide.alpha = 0.75-(0.75*differenceFromBeginPoint/280)
                    sideMenuBtn.tintColor = #colorLiteral(red: 0.8684186339, green: 0.8584913611, blue: 0.8543596268, alpha: 1)
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (isSideMenuShown) {
            if (difference>140) {
                UIView.animate(withDuration: 0.1) {
                    self.leadingConstraintForSideView.constant = -290
                } completion: { (status) in
                    self.backViewForSide.alpha = 0.0
                    self.isSideMenuShown = false
                    self.backViewForSide.isHidden = true
                }
            }
            else{
                UIView.animate(withDuration: 0.1) {
                    self.leadingConstraintForSideView.constant = -10
                } completion: { (status) in
                    self.backViewForSide.alpha = 0.75
                    self.isSideMenuShown = true
                    self.backViewForSide.isHidden = false
                }
            }
        }
    }

}



//MARK: SEARCHBAR
extension AllNewsViewController: UISearchBarDelegate {
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText == "" {
                makeSearch = false
            } else {
                viewModel.getSearchData(query: searchText) { _ in
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }


//MARK: TABLEVIEW
extension AllNewsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCountData()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllNewsCell", for: indexPath) as? AllNewsCell else { return UITableViewCell() }
        let object = viewModel.getCategoryModel(at: indexPath)
        cell.configure(model: object)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let articles = viewModel.categoryNews?.articles else { return }
        let news = viewModel.getCategoryModel(at: indexPath)
        let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "DetailViewController") as? DetailViewController {
            vc.detailViewModel = DetailViewModel(model: news)
        navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }

}
