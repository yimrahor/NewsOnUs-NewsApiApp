//
//  SideMenuCell.swift
//  NewsOnUs!
//
//  Created by Yaşar Ebru İmrahor on 11.09.2023.
//

import UIKit

class SideMenuCell: UITableViewCell {
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.backgroundColor = .clear
        self.iconImageView.tintColor = .white
        self.titleLabel.textColor = .white
    }
    
}
