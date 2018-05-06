//
//  ParkDetailManager.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/6.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import Foundation
import PromiseKit

protocol ParkDetailDelegate {
    var state: UIState<ParkSpot> { get set }
}

protocol ParkDetailHandler: class {
    var delegate: ParkDetailDelegate? { get set }
    func loadData()
}

final class ParkDetailManager: ParkDetailHandler {
    
    var delegate: ParkDetailDelegate?
    var getParkSpotList: GetParkSpotList
    var getParkFacilityList: GetParkFacilityList
    var parkName: String
    
    init(_ getParkSpotList: GetParkSpotList, _ getParkFacilityList: GetParkFacilityList, parkName: String) {
        self.getParkSpotList = getParkSpotList
        self.getParkFacilityList = getParkFacilityList
        self.parkName = parkName
    }
    
    func loadData() {
        delegate?.state = .Loading
        
        getParkSpotList.perform(name: parkName).then { [weak self] (list) in
            self?.delegate?.state = .Success(list.items)
        }.catch { e in
            print(e) // TODO: Handle
        }
    }
}
