//
//  FavoritesViewController.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/5.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit
import RxSwift

internal final class FavoritesViewController: UIViewController, Navigable {

    // MARK: - View Components
    var navigationBar: ColorgyNavigationBar = ColorgyNavigationBar()
    let tableView: UITableView = UITableView()
    
    var favoriteParkManager: FavoriteParkHandler
    var parkListUIController: FavoriteParkListUIController!
    
    // MARK: - Transition Delegate
    var navigationTransitionDelegate: ColorgyNavigationTransitioningDelegate? = ColorgyNavigationTransitioningDelegate()
    
    init(parkManager: FavoriteParkHandler) {
        self.favoriteParkManager = parkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureNavigationBar()
        configureTableView()
    
        parkListUIController = FavoriteParkListUIController(view: view, tableView: tableView)
        favoriteParkManager.delegate = parkListUIController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteParkManager.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureNavigationBar() {
        navigationBar.title = tabBarItem.title
        view.addSubview(navigationBar)
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

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let park = favoriteParkManager.parks[indexPath.row]
        let vc = ParkDetailViewController(
            park: park,
            parkDetailManager: ParkDetailManager(GetParkSpotList(), GetParkFacilityList(), parkName: park.parkName))
        navigationTransitionDelegate?.presentingViewController = vc
        self.asyncPresent(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? ParkCell {
            cell.starButton.rx.tap.asDriver().drive(onNext: { [weak self] in
                self?.favoriteParkManager.removePark(at: indexPath.row)
            }).disposed(by: cell.bag)
        }
    }
}


