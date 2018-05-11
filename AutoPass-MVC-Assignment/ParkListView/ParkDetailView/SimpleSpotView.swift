//
//  SimpleSpotView.swift
//  KK-Assignment
//
//  Created by 廖慶麟 on 2018/4/12.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit

protocol SimpleSpotViewDelegate: class {
    func simpleSpotViewDidTapped(_ spotView: SimpleSpotView)
}

internal final class SimpleSpotView: UIView {

    let imageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 195, height: 95))
    let nameLabel: UILabel = UILabel(frame: CGRect(x: 8, y: 0, width: 0, height: 0))
    
    weak var delegate: SimpleSpotViewDelegate?
    
    // MARK: - Init
    public convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 195, height: 120))

        backgroundColor = UIColor.white

        layer.cornerRadius = 3.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        clipsToBounds = true
        
        isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(tapGesture)
        
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
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        addSubview(imageView)
    }
    
    private func configureNameLabel() {
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        nameLabel.textColor = UIColor.darkText
        nameLabel.textAlignment = .left
        
        nameLabel.move(4, pointBelow: imageView)
        
        addSubview(nameLabel)
    }
    
    public func configure(with spot: ParkSpot) {
        imageView.sd_setImage(with: spot.imageURL, placeholderImage: #imageLiteral(resourceName: "DefaultImage"))
        
        nameLabel.text = spot.name
        nameLabel.sizeToFit()
        nameLabel.center.y = imageView.frame.maxY + (frame.maxY - imageView.frame.maxY)/2
    }
    
    @objc func tapped() {
        self.delegate?.simpleSpotViewDidTapped(self)
    }
}
