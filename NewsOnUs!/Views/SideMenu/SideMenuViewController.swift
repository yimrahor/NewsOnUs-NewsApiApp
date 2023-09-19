//
//  SideMenuViewController.swift
//  NewsOnUs!
//
//  Created by Yaşar Ebru İmrahor on 11.09.2023.
//

import UIKit

protocol SideMenuViewControllerDelegate {
    func hideSideMenu ()
}

class SideMenuViewController: UIViewController {
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var sideMenuTableView: UITableView!
    @IBOutlet weak var sideBackgroundView: UIView!
        
    var delegate: SideMenuViewControllerDelegate?
    var defaultHighlightedCell: Int = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        // TableView
        self.sideMenuTableView.backgroundColor = #colorLiteral(red: 0.8684186339, green: 0.8584913611, blue: 0.8543596268, alpha: 1)
        self.sideMenuTableView.separatorStyle = .none
        
        // Set Highlighted Cell
        DispatchQueue.main.async {
            let defaultRow = IndexPath(row: self.defaultHighlightedCell, section: 0)
            self.sideMenuTableView.selectRow(at: defaultRow, animated: false, scrollPosition: .none)
        }

        // Register TableView Cell
        self.sideMenuTableView.register(SideMenuCell.nib, forCellReuseIdentifier: SideMenuCell.identifier)

        // Update TableView with the data
        self.sideMenuTableView.reloadData()
    }
    
    func configureView() {
        self.sideMenuTableView.delegate = self
        self.sideMenuTableView.dataSource = self
    }
    
}



// MARK: - UITableView

extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Categories.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.identifier, for: indexPath) as? SideMenuCell else { fatalError("xib doesn't exist") }
        cell.iconImageView.image = UIImage(named: Categories.allCases[indexPath.row].imageName)
        cell.iconImageView.tintColor = .white
        cell.titleLabel.text = Categories.allCases[indexPath.row].rawValue
        cell.titleLabel.textColor = #colorLiteral(red: 0.08454743773, green: 0.2466894388, blue: 0.3876488507, alpha: 1)
        // Highlighted color
        let myCustomSelectionColorView = UIView()
        myCustomSelectionColorView.backgroundColor = #colorLiteral(red: 0.8684186339, green: 0.8584913611, blue: 0.8543596268, alpha: 1)
        cell.selectedBackgroundView = myCustomSelectionColorView
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = tableView.cellForRow(at: indexPath)
        selectedCell?.backgroundColor = UIColor.blue
        selectedCell?.selectionStyle = .blue
        
        let categories = Categories.allCases[indexPath.row].categoryName
        let storyboard = UIStoryboard(name: "TabBar", bundle: nil)        
        if let vc = storyboard.instantiateViewController(identifier: "AllNewsViewController") as? AllNewsViewController {
        vc.categories = categories
        self.navigationController?.pushViewController(vc, animated: true)
        }
        self.delegate?.hideSideMenu()
    }

}
