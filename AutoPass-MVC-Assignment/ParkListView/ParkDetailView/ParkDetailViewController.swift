//
//  ParkDetailViewController.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/6.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit

final class ParkDetailViewController: NavigationViewController {

    let park: Park
    let parkDetailManager: ParkDetailHandler
    private var parkDetailUIController: ParkDetailUIController!
    
    // MARK: - View Components
    var detailView: ParkDetailView = ParkDetailView()
    
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
        
        navigationBar.setButton(at: .left, type: .back)
        navigationBar.title = park.parkName
        navigationBar.delegate = self
        
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
        parkDetailManager.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ParkDetailViewController: ColorgyNavigationBarDelegate {
    func colorgyNavigationBarBackButtonClicked() {
        self.asyncDismiss(true)
    }
}

extension ParkDetailViewController: SimpleSpotViewDelegate {
    func simpleSpotViewDidTapped(_ spotView: SimpleSpotView) {
        if let spot = parkDetailManager.spots.filter({ $0.name == spotView.nameLabel.text }).first {
            let vc = SpotDetailViewController(spot: spot)
            navigationTransitionDelegate?.presentingViewController = vc
            self.asyncPresent(vc, animated: true)
        }
    }
}
