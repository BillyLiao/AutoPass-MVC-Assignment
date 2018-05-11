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
    var spotState : UIState<ParkSpot> { get set }
    var facilityState : UIState<ParkFacility> { get set }
}

protocol ParkDetailHandler: class {
    var spots: [ParkSpot] { get set }
    var facilities: [ParkFacility] { get set }
    
    var delegate: ParkDetailDelegate? { get set }
    func loadData()
}

final class ParkDetailManager: ParkDetailHandler {
    
    var delegate: ParkDetailDelegate?
    let getParkSpotList: GetParkSpotList
    let getParkFacilityList: GetParkFacilityList
    let parkName: String
    
    internal var spots: [ParkSpot] = []
    internal var facilities: [ParkFacility] = []
    
    init(_ getParkSpotList: GetParkSpotList, _ getParkFacilityList: GetParkFacilityList, parkName: String) {
        self.getParkSpotList = getParkSpotList
        self.getParkFacilityList = getParkFacilityList
        self.parkName = parkName
    }
    
    func loadData() {
        delegate?.spotState = .Loading
        delegate?.facilityState = .Loading

        when(fulfilled:
        getParkSpotList.perform(name: parkName),
        getParkFacilityList.perform(name: parkName))
        .then { [weak self] (spotList, facilityList) -> Void in
            self?.spots = spotList.items
            self?.facilities = facilityList.items
            self?.delegate?.spotState = .Success(spotList.items)
            self?.delegate?.facilityState = .Success(facilityList.items)
            return
        }.catch { (e) in
            print(e)
        }
    }
}
