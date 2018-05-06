//
//  RelatedSpotView.swift
//  KK-Assignment
//
//  Created by 廖慶麟 on 2018/4/12.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit

internal final class RelatedSpotView: UIScrollView {

    private var simpleViews: [SimpleSpotView] = [SimpleSpotView]()
    
    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        alwaysBounceHorizontal = true
        showsHorizontalScrollIndicator = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with parks: [Park]) {
        guard parks.count != 0 else { return }
        
        for (index, park) in parks.enumerated() {
            let simpleSpotView = SimpleSpotView()
            simpleSpotView.configure(with: park)
            simpleSpotView.frame.origin.x = (simpleSpotView.frame.width + 5) * index.cgFloat
            
            addSubview(simpleSpotView)
            
            simpleViews.append(simpleSpotView)
        }
        
        self.contentSize = CGSize(width: simpleViews.last!.frame.maxX, height: frame.height)
    }
}
