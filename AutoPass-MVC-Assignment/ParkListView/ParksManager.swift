//
//  ParksManager.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/5.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import Foundation

enum UIState<T> {
    case Loading
    case Success([T])
    case Failure
}

protocol ParksDelegate {
    var state: UIState<Park> { get set }
}

protocol ParksHandler: class {
    var delegate: ParksDelegate? { get set }
    var parks: [Park] { get set }
    var realmManager: RealmManager<FavoritesParkTable> { get set }

    func loadData(page: Int)
    func parkStarredStateChanged(index: Int, to: Bool)
}

final class ParksManager: ParksHandler {
    var delegate: ParksDelegate?

    let networkRequest: GetParkList
    var parks: [Park] = []
    var realmManager: RealmManager<FavoritesParkTable>

    init(_ networkRequest: GetParkList, realmManager: RealmManager<FavoritesParkTable>) {
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
    
    func parkStarredStateChanged(index: Int, to: Bool) {
        let id = parks[index].id
        
        if to == true {
            let realmObject = FavoritesParkTable()
            realmObject.id = id
            try? realmManager.add(object: realmObject, completionHandler: nil)
        }else {
            try? realmManager.remove(id: id, completionHandler: nil)
        }
    }
}
