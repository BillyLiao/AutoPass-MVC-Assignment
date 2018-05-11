//
//  ParksManager.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/5.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import Foundation
import CoreLocation

enum UIState<T> {
    case Loading
    case Success([T])
    case Refresh([T])
    case Failure
}

protocol ParksDelegate {
    var state: UIState<Park> { get set }
}

protocol ParksHandler: class {
    var delegate: ParksDelegate? { get set }
    var parks: [Park] { get set }
    var realmManager: RealmManager<FavoriteParkRealmObject> { get set }

    func loadData(page: Int)
    func refresh()
    func parkStarredStateChanged(index: Int, to state: Bool)
    func parkStarredStateChanged(park: Park, to state: Bool)
    func getClosestPark(to location: CLLocation) -> Park?
}

final class ParksManager: ParksHandler {
    var delegate: ParksDelegate?

    let networkRequest: GetParkList
    var parks: [Park] = []
    var realmManager: RealmManager<FavoriteParkRealmObject>

    init(_ networkRequest: GetParkList, realmManager: RealmManager<FavoriteParkRealmObject>) {
        self.networkRequest = networkRequest
        self.realmManager = realmManager
    }
    
    func loadData(page: Int = 0) {
        guard let _ = self.delegate else { fatalError("Delegate needed") }
        
        delegate?.state = .Loading
        networkRequest.perform(offset: page).then { [weak self] (list) -> Void in
            self?.parks.append(contentsOf: list.items)
            self?.delegate?.state = .Success(list.items)
            return
        }.catch { (e) in
            print(e)
        }
    }
    
    func refresh() {
        delegate?.state = .Refresh(parks)
    }
    
    func parkStarredStateChanged(index: Int, to state: Bool) {
        let park = parks[index]
        
        if state == true {
            let realmObject = FavoriteParkRealmObject(park)
            try? realmManager.add(object: realmObject, completionHandler: nil)
        }else {
            try? realmManager.remove(id: park.id, completionHandler: nil)
        }
    }

    func parkStarredStateChanged(park: Park, to state: Bool) {
        guard let index = parks.index(where: { $0.id == park.id }) else { return }
        parkStarredStateChanged(index: index, to: state)
    }
    
    func getClosestPark(to location: CLLocation) -> Park? {
        var minDistance = CLLocationDistanceMax
        var closetTarget: Park?
        parks.forEach { (park) in
            let parkLocation = CLLocation(latitude: park.coordinate.latitude, longitude: park.coordinate.longitude)
            if location.distance(from: parkLocation) < minDistance {
                minDistance = location.distance(from: parkLocation)
                closetTarget = park
            }
        }
        
        return closetTarget
    }
}
