//
//  ParkDetailViewController.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/6.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit

final class ParkDetailViewController: UIViewController, Navigable {

    let park: Park
    let parkDetailManager: ParkDetailHandler
    private var parkDetailUIController: ParkDetailUIController!
    
    // MARK: - View Components
    var navigationBar: ColorgyNavigationBar = ColorgyNavigationBar()
    var detailView: ParkDetailView = ParkDetailView()
    
    // MARK: TransitioningDelegate
    var navigationTransitionDelegate: ColorgyNavigationTransitioningDelegate? = ColorgyNavigationTransitioningDelegate()
    
    init(park: Park, parkDetailManager: ParkDetailHandler) {
        self.park = park
        self.parkDetailManager = parkDetailManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
        view.addSubview(detailView)
        detailView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(navigationBar.snp.bottom)
        }
        
        detailView.contentView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
        }
        
        parkDetailUIController = ParkDetailUIController(parkDetailView: detailView)
        parkDetailManager.delegate = parkDetailUIController
        
        detailView.configure(with: park)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureNavigationBar() {
        view.addSubview(navigationBar)
        navigationBar.setButton(at: .left, type: .back)
        navigationBar.title = "公園資訊"
        navigationBar.delegate = self
    }
}

extension ParkDetailViewController: ColorgyNavigationBarDelegate {
    func colorgyNavigationBarBackButtonClicked() {
        self.asyncDismiss(true)
    }
}
