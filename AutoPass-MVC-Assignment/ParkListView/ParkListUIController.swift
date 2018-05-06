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
            
        case (.Loading, .Loading): loadingToLoading()
        case (.Loading, .Success(let parks)): loadingToSuccess(parks)
         case (.Success, .Loading): loadingToLoading()
            
        default: fatalError("Not yet implemented \(state) to \(newState)")
        }
    }
    
    func loadingToLoading() {
        view.addSubview(loadingView)
        loadingView.frame = CGRect(origin: .zero, size: view.frame.size)
    }
    
    func loadingToSuccess(_ parks: [DataType]) {
        loadingView.removeFromSuperview()
        tableViewDataSource.dataSource.append(contentsOf: parks.map(ParkCellConfigurator.init))
    }
}

//extension ParkListViewController: UITableViewDataSourcePrefetching {
//
//}

