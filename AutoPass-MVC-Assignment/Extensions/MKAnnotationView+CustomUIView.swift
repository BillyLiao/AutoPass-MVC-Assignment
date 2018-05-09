//
//  MKAnnotationView+CustomUIView.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/9.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import MapKit

extension MKAnnotationView {
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let rect = self.bounds
        var isInside: Bool = rect.contains(point)
        if !isInside {
            for view in self.subviews {
                isInside = view.frame.contains(point)
                if isInside { break }
            }
        }
        return isInside
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if hitView != nil {
            self.superview?.bringSubview(toFront: self)
        }
        return hitView
    }
}
