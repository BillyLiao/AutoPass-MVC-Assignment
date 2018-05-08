//
//  CustomCalloutView.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/8.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit
import SnapKit

final class CustomCalloutView: UIView {

    let nameLabel: UILabel = UILabel()
    let adminLabel: UILabel = UILabel()
    let openTimeLabel: UILabel = UILabel()
    let starButton: StarButton = StarButton()
    let navigationButton: UIButton = UIButton()
    
    // MARK: - Init
    public convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 150, height: 80))
    
        layer.cornerRadius = 5.0
        layer.borderWidth = 1.0
        layer.borderColor = CustomColor.mainBlueGreen.cgColor
        clipsToBounds = true
        backgroundColor = UIColor.white
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        adminLabel.font = UIFont.systemFont(ofSize: 14)
        adminLabel.textColor = UIColor.gray
        openTimeLabel.font = UIFont.systemFont(ofSize: 14)
        openTimeLabel.textColor = UIColor.gray
        navigationButton.setTitleColor(CustomColor.mainBlueGreen, for: .normal)
        navigationButton.setTitle("Go!", for: .normal)
        
        addSubview(nameLabel)
        addSubview(adminLabel)
        addSubview(openTimeLabel)
        addSubview(starButton)
        addSubview(navigationButton)
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        starButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(30)
            make.right.top.equalToSuperview().inset(8)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().inset(8)
            make.right.equalTo(starButton.snp.left).offset(8)
        }
        
        navigationButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(30)
            make.right.equalToSuperview().inset(8)
            make.top.equalTo(starButton.snp.bottom).offset(4)
        }
        
        adminLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(8)
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.right.equalTo(navigationButton.snp.left).inset(8)
        }
        
        openTimeLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(8)
            make.top.equalTo(adminLabel.snp.bottom).offset(4)
            make.right.equalTo(navigationButton.snp.left).inset(8)
        }
    }
    
    func configure(with park: Park) {
        nameLabel.text = park.parkName
        adminLabel.text = park.adminArea
        openTimeLabel.text = park.openTime == "" ? "查無開放時間" : park.openTime
    }
}
