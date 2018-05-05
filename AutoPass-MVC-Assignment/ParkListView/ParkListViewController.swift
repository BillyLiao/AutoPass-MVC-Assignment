//
//  ParkListViewController.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/5.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit
import SnapKit

internal final class ParkListViewController: UIViewController, Navigable {
    
    // MARK: - View Components
    var navigationBar: ColorgyNavigationBar = ColorgyNavigationBar()
    let tableView: UITableView = UITableView()
    
    // MARK: - Transitioning Delegate
    var navigationTransitionDelegate: ColorgyNavigationTransitioningDelegate? = ColorgyNavigationTransitioningDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        configureNavigationBar()
        configureTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - View Configuration
    func configureNavigationBar() {
        view.addSubview(navigationBar)
        navigationBar.title = tabBarItem.title
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.tableFooterView = UIView()
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(navigationBar.snp.bottom)
        }
    }
}
