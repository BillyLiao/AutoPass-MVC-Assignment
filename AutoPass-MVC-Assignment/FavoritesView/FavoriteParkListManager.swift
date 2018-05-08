//
//  FavoriteParkListManager.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/7.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import Foundation

protocol FavoriteParkHandler {
    var delegate: ParksDelegate? { get set }
    var parks: [Park] { get set }
    var realmManager: RealmManager<FavoriteParkRealmObject> { get set }
    
    func loadData()
    func removePark(at index: Int)
}

final class FavoriteParkManager: FavoriteParkHandler {
    
    var delegate: ParksDelegate?
    var parks: [Park] = []
    var realmManager: RealmManager<FavoriteParkRealmObject>
    
    init(realmManager: RealmManager<FavoriteParkRealmObject>) {
        self.realmManager = realmManager
    }
    
    func loadData() {
        delegate?.state = .Loading
        do {
            var parks = (try realmManager.query()).map{Park.init(realmObject: $0)}
            self.parks = parks
            delegate?.state = .Success(parks)
        } catch let e {
            print(e)
            // TODO: Handle
        }
    }
    
    func removePark(at index: Int) {
        print(index)
        let park = parks[index]

        do {
            try realmManager.remove(id: park.id, completionHandler: { [weak self] (suceess) in
                self?.loadData()
            })
        }catch let e {
            // TODO: Handle
        }
    }
}
