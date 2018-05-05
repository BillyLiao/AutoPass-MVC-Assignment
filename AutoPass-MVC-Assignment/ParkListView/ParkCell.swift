//
//  ParkCell.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/5.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit
import SnapKit
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
    
    let mainContentView: UIView = UIView()
    let mainImageView: UIImageView = UIImageView()
    let nameLabel: UILabel = UILabel()
    let adminAreaLabel: UILabel = UILabel()
    let introLabel: UILabel = UILabel()
    let starButton: UIButton = UIButton()
    let mapButton: UIButton = UIButton()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addSubview(mainContentView)
        mainContentView.layer.cornerRadius = 5.0
        mainContentView.clipsToBounds = true
        mainContentView.backgroundColor = UIColor.white
        mainContentView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(8)
        }
        
        mainContentView.addSubview(mainImageView)
        mainImageView.layer.cornerRadius = 22
        mainImageView.clipsToBounds = true
        mainImageView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().inset(4)
            make.width.height.equalTo(44)
        }
        
        mainContentView.addSubview(starButton)
        starButton.setTitle("Favorite", for: .normal)
        starButton.snp.makeConstraints { (make) in
            make.top.equalTo(mainImageView.snp.top)
            make.trailing.equalToSuperview().inset(8)
        }
        
        mainContentView.addSubview(mapButton)
        mapButton.setTitle("Map", for: .normal)
        mapButton.snp.makeConstraints { (make) in
            make.right.equalTo(starButton.snp.right)
            make.top.equalTo(starButton.snp.bottom).offset(8)
        }
        
        mainContentView.addSubview(nameLabel)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(mainImageView).inset(10)
            make.right.equalTo(starButton).inset(10)
            make.centerY.equalTo(starButton)
        }
        
        mainContentView.addSubview(adminAreaLabel)
        adminAreaLabel.font = UIFont.systemFont(ofSize: 17)
        adminAreaLabel.textColor = UIColor.gray
        adminAreaLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.right.equalTo(mapButton).inset(10)
            make.centerY.equalTo(mapButton)
        }
        
        mainContentView.addSubview(introLabel)
        introLabel.font = UIFont.systemFont(ofSize: 14)
        introLabel.textColor = UIColor.lightGray
        introLabel.numberOfLines = 5
        introLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(4)
            make.top.equalTo(mainImageView.snp.bottom).offset(16)
        }
    }
}
