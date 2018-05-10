//
//  ParkDetailView.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/6.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit
import SnapKit

final class ParkDetailView: UIScrollView {

    let contentView: UIView = UIView()
    let mainImageView: UIImageView = UIImageView()
    let infoView: ParkBasicInfoView = ParkBasicInfoView()
    let introLabel: UILabel = UILabel()
    let relatedSpotView: RelatedSpotView = RelatedSpotView()
    
    // MARK: - Init
    public convenience init() {
        self.init(frame: CGRect.zero)
        
        backgroundColor = UIColor.white
        alwaysBounceVertical = true
        
        addSubview(contentView)
        mainImageView.contentMode = .scaleAspectFit
        contentView.addSubview(mainImageView)
        contentView.addSubview(infoView)
        introLabel.font = UIFont.systemFont(ofSize: 16)
        introLabel.textColor = UIColor.lightGray
        introLabel.numberOfLines = 0
        contentView.addSubview(introLabel)
        contentView.addSubview(relatedSpotView)
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with park: Park) {
        mainImageView.sd_setImage(with: park.imageURL, placeholderImage: #imageLiteral(resourceName: "DefaultImage"))
        infoView.configure(with: park)
        introLabel.text = park.intro
    }
    
    override func layoutSubviews() {
        contentView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
        }
        
        mainImageView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(12)
            make.height.equalTo(200)
        }
        
        infoView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(12)
            make.top.equalTo(mainImageView.snp.bottom).offset(12)
            make.height.equalTo(140)
        }
        
        introLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(12)
            make.top.equalTo(infoView.snp.bottom).offset(16)
        }
        
        relatedSpotView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(150)
            make.top.equalTo(introLabel.snp.bottom).offset(12)
        }
        
        contentSize = CGSize(width: contentSize.width , height: relatedSpotView.frame.maxY + 16)
    }
}
