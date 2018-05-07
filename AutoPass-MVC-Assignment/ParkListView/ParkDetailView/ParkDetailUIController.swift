//
//  ParkDetailUIController.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/6.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit

final class ParkDetailUIController: ParkDetailDelegate {
    
    var spotState: UIState<ParkSpot> = .Loading {
        willSet(newState) {
            update(newState: newState)
        }
    }
    
    var facilityState: UIState<ParkFacility> = .Loading {
        willSet(newState) {
            update(newState: newState)
        }
    }
    
    private unowned let parkDetailView: ParkDetailView
    
    init(parkDetailView: ParkDetailView) {
        self.parkDetailView = parkDetailView
    }
    
    func update(newState: UIState<ParkSpot>) {
        switch(spotState, newState) {
        case (.Loading, .Loading): print("loading...")
        case (.Loading, .Success(let spots)): parkDetailView.relatedSpotView.configure(with: spots)
            
        default: fatalError("Not yet implemented \(spotState) to \(newState)")
        }
    }
    
    func update(newState: UIState<ParkFacility>) {
        switch(facilityState, newState) {
        case (.Loading, .Loading): print("loading...")
        case (.Loading, .Success(let facilities)): parkDetailView.infoView.configure(with: facilities)
            
        default: fatalError("Not yet implemented \(facilityState) to \(newState)")
        }
    }
}
