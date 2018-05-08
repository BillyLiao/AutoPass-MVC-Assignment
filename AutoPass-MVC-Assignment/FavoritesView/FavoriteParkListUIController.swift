//
//  FavoriteParkListUIController.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/8.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit

final class FavoriteParkListUIController {
    typealias DataType = Park
    
    private unowned var view: UIView
    private let loadingView: LoadingView
    private let tableViewDataSource: TableViewDataSource<ParkCellConfigurator, ParkCell>
    
    var state: UIState<DataType> = .Loading {
        willSet(newValue) {
            update(newValue)
        }
    }
    
    init(view: UIView, tableView: UITableView) {
        self.view = view
        self.loadingView = LoadingView(frame: CGRect(origin: .zero, size: tableView.frame.size))
        self.tableViewDataSource = TableViewDataSource<ParkCellConfigurator, ParkCell>(tableView: tableView)
        tableView.dataSource = tableViewDataSource
        update(state)
    }
}

extension FavoriteParkListUIController: ParksDelegate {
    func update(_ newState: UIState<DataType>) {
        switch(state, newState) {
        case (.Loading, .Loading): toLoading()
        case (.Loading, .Success(let parks)): toSuccess(parks)
        case (.Success, .Loading): print("do nothing")
        
        default: fatalError("\(state) to \(newState) not implemented...")
        }
    }
    
    func toLoading() {
        view.addSubview(loadingView)
        loadingView.frame = CGRect(origin: .zero, size: view.frame.size)
    }
    
    func toSuccess(_ parks: [DataType]) {
        loadingView.removeFromSuperview()
        tableViewDataSource.dataSource = parks.map(ParkCellConfigurator.init)
    }
}
