//
//  ParkListUIController.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/5.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit

final class ParkListUIController {
    typealias DataType = Park
    
    private unowned var view: UIView
    private let loadingView: LoadingView
    private let tableViewDataSource: TableViewDataSource<ParkCellConfigurator, ParkCell>

    var state: UIState<DataType> = .Loading {
        willSet(newState) {
            update(newState)
        }
    }
    
    init(view: UIView, tableView: UITableView) {
        self.view = view
        self.loadingView = LoadingView.init(frame: CGRect.init(origin: .zero, size: tableView.frame.size))
        self.tableViewDataSource = TableViewDataSource<ParkCellConfigurator, ParkCell>(tableView: tableView)
        tableView.dataSource = tableViewDataSource
        update(state)
    }
}

extension ParkListUIController: ParksDelegate {
    func update(_ newState: UIState<DataType>) {
        switch(state, newState) {
            
        case (.Loading, .Loading): toLoading()
        case (.Loading, .Refresh): print("loading to refresh")
        case (.Loading, .Success(let parks)): toSuccess(parks)
        case (.Refresh, .Success(let parks)): toSuccess(parks)
        case (.Success, .Loading): toLoading()
        case (.Success, .Refresh(let parks)): toRefresh(parks)
        case (.Refresh, .Loading): toLoading()
        case (.Refresh, .Refresh(let parks)): toRefresh(parks)
            
        default: fatalError("Not yet implemented \(state) to \(newState)")
        }
    }
    
    func toLoading() {
        view.addSubview(loadingView)
        loadingView.frame = CGRect(origin: .zero, size: view.frame.size)
    }
    
    func toSuccess(_ parks: [DataType]) {
        loadingView.removeFromSuperview()
        tableViewDataSource.dataSource.append(contentsOf: parks.map(ParkCellConfigurator.init))
    }
    
    func toRefresh(_ parks: [DataType]) {
        tableViewDataSource.dataSource = parks.map(ParkCellConfigurator.init)
    }
}
