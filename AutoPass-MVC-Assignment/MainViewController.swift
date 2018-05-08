//
//  MainViewController.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/5.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit

internal final class MainViewController: UITabBarController {

    // MARK: - View Controllers
    var vcs: [UIViewController] = []
    
    var parksHandler: ParksHandler = ParksManager(GetParkList(), realmManager: RealmManager<FavoriteParkRealmObject>())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vcs = [ParkListViewController(parksHandler: parksHandler),
               MapViewController(parksHandler: parksHandler),
               FavoritesViewController(parkManager: FavoriteParkManager(realmManager: RealmManager<FavoriteParkRealmObject>()))]
        
        // Do any additional setup after loading the view.
        setupBarItems()
        
        selectedIndex = 1
        
        tabBar.tintColor = CustomColor.mainBlueGreen
        tabBar.isTranslucent = false

        setViewControllers(vcs, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupBarItems() {
        vcs[0].tabBarItem = UITabBarItem(title: "公園列表", image: #imageLiteral(resourceName: "ListIcon"), tag: 0)
        vcs[1].tabBarItem = UITabBarItem(title: "地圖資訊", image: #imageLiteral(resourceName: "MapIcon"), tag: 1)
        vcs[2].tabBarItem = UITabBarItem(title: "收藏清單", image: #imageLiteral(resourceName: "FavoritesListIcon"), tag: 2)
    }
}
