//
//  ParkDetailUIController.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/6.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit

final class ParkDetailUIController: ParkDetailDelegate {
    typealias DataType = ParkSpot
    
    var state: UIState<DataType> = .Loading {
        willSet(newState) {
            update(newState: newState)
        }
    }
    
    private unowned let parkDetailView: ParkDetailView
    
    init(parkDetailView: ParkDetailView) {
        self.parkDetailView = parkDetailView
    }
    
    func update(newState: UIState<DataType>) {
        switch(state, newState) {
        case (.Loading, .Loading): print("loading...")
        case (.Loading, .Success(let spots)): parkDetailView.relatedSpotView.configure(with: spots)
            
        default: fatalError("Not yet implemented \(state) to \(newState)")
        }
    }
}
