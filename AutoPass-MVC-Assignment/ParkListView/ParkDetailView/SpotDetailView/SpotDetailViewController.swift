//
//  SpotDetailViewController.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/7.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit

final class SpotDetailViewController: UIViewController, Navigable {

    var navigationBar: ColorgyNavigationBar = ColorgyNavigationBar()
    var spotDetailView: SpotDetailView = SpotDetailView()
    
    let spot: ParkSpot
    
    var navigationTransitionDelegate: ColorgyNavigationTransitioningDelegate?
    
    init(spot: ParkSpot) {
        self.spot = spot
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        configureNavigationBar()
        
        view.addSubview(spotDetailView)
        spotDetailView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(12)
            make.bottom.equalToSuperview()
            make.top.equalTo(navigationBar.snp.bottom).offset(12)
        }
        
        spotDetailView.contentView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view).inset(12)
        }
        
        spotDetailView.configure(with: spot)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configureNavigationBar() {
        view.addSubview(navigationBar)
        navigationBar.setButton(at: .left, type: .back)
        navigationBar.title = spot.parkName
        navigationBar.delegate = self
    }
}

extension SpotDetailViewController: ColorgyNavigationBarDelegate {
    func colorgyNavigationBarBackButtonClicked() {
        self.asyncDismiss(true)
    }
}
