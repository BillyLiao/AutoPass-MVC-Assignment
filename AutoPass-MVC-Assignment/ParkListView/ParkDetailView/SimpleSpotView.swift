//
//  SimpleSpotView.swift
//  KK-Assignment
//
//  Created by 廖慶麟 on 2018/4/12.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit

internal final class SimpleSpotView: UIView {

    private var imageView: UIImageView!
    private var nameLabel: UILabel!
    
    // MARK: - Init
    public convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 195, height: 90))

        backgroundColor = UIColor.white

        layer.cornerRadius = 3.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        clipsToBounds = true
        
        configureImageView()
        configureNameLabel()
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Configuration
    private func configureImageView() {
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 195, height: 65))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        addSubview(imageView)
    }
    
    private func configureNameLabel() {
        nameLabel = UILabel(frame: CGRect(x: 8, y: 0, width: 0, height: 0))
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        nameLabel.textColor = UIColor.darkText
        nameLabel.textAlignment = .left
        
        nameLabel.move(4, pointBelow: imageView)
        
        addSubview(nameLabel)
    }
    
    public func configure(with spot: ParkSpot) {
        imageView.sd_setImage(with: spot.imageURL, placeholderImage: #imageLiteral(resourceName: "DefaultImage"))
        
        nameLabel.text = spot.parkName
        nameLabel.sizeToFit()
        nameLabel.center.y = imageView.frame.maxY + (frame.maxY - imageView.frame.maxY)/2
    }
}
