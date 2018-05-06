//
//  TableViewDataSource.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/5.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit

final class TableViewDataSource<Model, Cell: UITableViewCell>: NSObject, UITableViewDataSource where Cell: Reusable, Cell: CellConfigurable, Model == Cell.Configurator {
    
    var dataSource: [Model] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private unowned var tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        tableView.registerReusableCell(Cell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: Cell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.cellConfigurator = dataSource[indexPath.row]
        return cell
    }
}
