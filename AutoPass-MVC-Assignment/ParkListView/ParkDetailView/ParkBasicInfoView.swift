//
//  ParkBasicInfoView.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/6.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit
import SnapKit

final class ParkBasicInfoView: UIView {
    
    // MARK: - View Components
    let nameLabel: UILabel = UILabel()
    let typeLabel: UILabel = UILabel()
    let locationLabel: UILabel = UILabel()
    let openTimeLabel: UILabel = UILabel()
    let facilityLabel: UILabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        
        addSubview(nameLabel)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
        }
        
        addSubview(typeLabel)
        typeLabel.font = UIFont.systemFont(ofSize: 17)
        typeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
        
        addSubview(locationLabel)
        locationLabel.font = UIFont.systemFont(ofSize: 17)
        locationLabel.textColor = UIColor.darkGray
        locationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(typeLabel.snp.bottom).offset(8)
        }
        
        addSubview(openTimeLabel)
        openTimeLabel.font = UIFont.systemFont(ofSize: 16)
        openTimeLabel.textColor = UIColor.darkGray
        openTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(locationLabel.snp.bottom).offset(8)
        }
        
        addSubview(facilityLabel)
        facilityLabel.font = UIFont.systemFont(ofSize: 16)
        facilityLabel.textColor = UIColor.darkGray
        facilityLabel.snp.makeConstraints { (make) in
            make.top.equalTo(openTimeLabel.snp.bottom).offset(8)
        }
        
        self.subviews.forEach { (view) in
            view.snp.makeConstraints({ (make) in
                make.left.right.equalToSuperview()
            })
        }
    }
    
    func configure(with park: Park) {
        nameLabel.text = park.parkName
        typeLabel.text = park.type
        locationLabel.text = "\(park.adminArea)  \(park.location)"
        openTimeLabel.text = park.openTime.isEmpty ? "查無開放時間" : park.openTime
    }
    
    func configure(with facilities: [ParkFacility]) {
        facilityLabel.text = "設施：" + facilities.map{ $0.name }.joined(separator: "、")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
