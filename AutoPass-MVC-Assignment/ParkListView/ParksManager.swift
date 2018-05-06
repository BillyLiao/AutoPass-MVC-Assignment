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
    func loadData(page: Int)
}

final class ParksManager: ParksHandler {
    private let networkRequest: GetParkList
    var delegate: ParksDelegate?
    
    init(networkRequest: GetParkList) {
        self.networkRequest = networkRequest
    }
    
    func loadData(page: Int = 0) {
        guard let _ = self.delegate else { fatalError("Delegate needed") }
        
        delegate?.state = .Loading
        networkRequest.perform(offset: page).then { [weak self] (list) in
            self?.delegate?.state = .Success(list.items)
        }.catch { (e) in
            print(e)
        }
    }
}
