//
//  ParkListViewController.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/5.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import MapKit

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
    
    override func viewWillAppear(_ animated: Bool) {
        parksHandler.refresh()
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
        
        if let cell = cell as? ParkCell {
            cell.mapButton.rx.tap.asDriver().drive(onNext: { [weak self] in
                let rootViewController = UIApplication.shared.delegate?.window??.rootViewController
                (rootViewController as? MainViewController)?.selectedIndex = 1
                ((rootViewController as? MainViewController)?.selectedViewController as? MapViewController)?.targetPark = self?.parksHandler.parks[indexPath.row]
            }).disposed(by: cell.bag)
            
            cell.starButton.rx.tap.asDriver().drive(onNext: { [weak self] in
                if let wasStarred = cell.cellConfigurator?.starred {
                    cell.cellConfigurator!.starred = !wasStarred
                    self?.parksHandler.parkStarredStateChanged(index: indexPath.row, to: !wasStarred)
                }
            }).disposed(by: cell.bag)
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

