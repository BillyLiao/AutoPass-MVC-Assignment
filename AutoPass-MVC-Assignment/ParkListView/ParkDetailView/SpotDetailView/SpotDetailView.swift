//
//  SpotDetailView.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/7.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

final class SpotDetailView: UIScrollView {
    // MARK: - View Components
    let spotImageView: UIImageView = UIImageView()
    let parkNameLabel: UILabel = UILabel()
    let spotNameLabel: UILabel = UILabel()
    let openTimeLabel: UILabel = UILabel()
    let introLabel: UILabel = UILabel()

    init() {
        super.init(frame: .zero)
        parkNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        spotNameLabel.font = UIFont.systemFont(ofSize: 17)
        openTimeLabel.font = UIFont.systemFont(ofSize: 16)
        openTimeLabel.textColor = UIColor.darkGray
        introLabel.font = UIFont.systemFont(ofSize: 16)
        introLabel.textColor = UIColor.lightGray
        
        addSubview(spotImageView)
        addSubview(parkNameLabel)
        addSubview(spotNameLabel)
        addSubview(openTimeLabel)
        addSubview(introLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        subviews.forEach { (view) in
            view.snp.makeConstraints({ (make) in
                make.left.right.equalToSuperview()
            })
        }
        
        spotImageView.snp.makeConstraints { (make) in
            make.height.equalTo(200)
            make.top.equalToSuperview()
        }
        
        parkNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(spotImageView.snp.bottom).offset(12)
        }
        
        spotNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(parkNameLabel.snp.bottom).offset(4)
        }
        
        openTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(spotNameLabel.snp.bottom).offset(4)
        }
        
        introLabel.snp.makeConstraints { (make) in
            make.top.equalTo(openTimeLabel.snp.bottom).offset(12)
        }
    }
    
    func configure(with spot: ParkSpot) {
        spotImageView.sd_setImage(with: spot.imageURL, placeholderImage: #imageLiteral(resourceName: "DefaultImage"))
        parkNameLabel.text = spot.parkName
        spotNameLabel.text = spot.name
        openTimeLabel.text = spot.openTime
        introLabel.text = spot.intro
    }
}
