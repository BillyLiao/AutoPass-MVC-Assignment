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
    private let parksHandler: ParksHandler
    private var parkListUIController: ParkListUIController!
    private let tableView: UITableView = UITableView()
    
    // MARK: - Transitioning Delegate
    var navigationTransitionDelegate: ColorgyNavigationTransitioningDelegate? = ColorgyNavigationTransitioningDelegate()
    
    init(parksHandler: ParksHandler) {
        
        self.parksHandler = parksHandler
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        configureNavigationBar()
        configureTableView()
        
        parkListUIController = ParkListUIController(view: view, tableView: tableView)
        parksHandler.delegate = parkListUIController
        
        parksHandler.loadData(page: 0)
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
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(navigationBar.snp.bottom)
        }
    }
}

extension ParkListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row+1) == tableView.numberOfRows(inSection: indexPath.section)-5 {
            parksHandler.loadData(page: (indexPath.row+1)/10)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let park = parksHandler.parks[indexPath.row]
        let vc = ParkDetailViewController(
            park: park,
            parkDetailManager: ParkDetailManager(GetParkSpotList(), GetParkFacilityList(), parkName: park.parkName))
        navigationTransitionDelegate?.presentingViewController = vc
        self.asyncPresent(vc, animated: true)
    }
}

