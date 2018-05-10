//
//  StarButton.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/8.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit
import RxSwift

final class StarButton: UIButton {

    let bag = DisposeBag()
    
    // MARK: - Init
    public convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        setTitle("", for: .normal)
        setImage(#imageLiteral(resourceName: "FavoriteButtonUnfilledIcon").withRenderingMode(.alwaysOriginal), for: .normal)
        setImage(#imageLiteral(resourceName: "FavoriteButtonFilledIcon").withRenderingMode(.alwaysOriginal), for: .selected)
        
        rx.tap.asDriver().drive(onNext: { [weak self] in
            self?.isSelected = !(self?.isSelected ?? true)
        }).disposed(by: bag)
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
