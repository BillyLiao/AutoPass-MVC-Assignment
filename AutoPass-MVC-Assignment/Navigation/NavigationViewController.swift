//
//  NavigationViewController.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/10.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit

class NavigationViewController: UIViewController, Navigable {

    var navigationBar: ColorgyNavigationBar = ColorgyNavigationBar()
    
    var navigationTransitionDelegate: ColorgyNavigationTransitioningDelegate? = ColorgyNavigationTransitioningDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configureNavigationBar() {
        view.addSubview(navigationBar)
    }
}
