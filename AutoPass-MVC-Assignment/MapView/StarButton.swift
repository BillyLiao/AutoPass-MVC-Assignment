//
//  StarButton.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/8.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit

final class StarButton: UIButton {

    // MARK: - Init
    public convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        self.setTitle("", for: .normal)
        self.setImage(#imageLiteral(resourceName: "FavoriteButtonUnfilledIcon").withRenderingMode(.alwaysOriginal), for: .normal)
        self.setImage(#imageLiteral(resourceName: "FavoriteButtonFilledIcon").withRenderingMode(.alwaysOriginal), for: .selected)
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
