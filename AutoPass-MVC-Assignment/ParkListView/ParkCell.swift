//
//  ParkCell.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/5.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit
import SDWebImage

extension ParkCell: CellConfigurable {}
extension ParkCell: Reusable {}

final class ParkCell: UITableViewCell {
    
    var cellConfigurator: ParkCellConfigurator? {
        didSet {
            guard let configurator = cellConfigurator else { return }
            
            mainImageView.sd_setImage(with: configurator.imageURL, placeholderImage: #imageLiteral(resourceName: "DefaultImage"))
            nameLabel.text = configurator.name
            adminAreaLabel.text = configurator.adminArea
            introLabel.text = configurator.introduction
        }
    }
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var adminAreaLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var introLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        mainImageView.layer.cornerRadius = mainImageView.frame.width/2
        mainImageView.clipsToBounds = true
        starButton.setTitle("Favorite", for: .normal)
        mapButton.setTitle("Map", for: .normal)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        adminAreaLabel.font = UIFont.systemFont(ofSize: 17)
        introLabel.font = UIFont.systemFont(ofSize: 14)
        introLabel.textColor = UIColor.lightGray
    }
}
