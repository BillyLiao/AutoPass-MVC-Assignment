//
//  ParkCellConfigurator.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/5.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit

protocol ParkCellRepresentable {
    var imageURL: URL { get }
    var name: String { get }
    var adminArea: String { get }
    var introduction: String { get }
    var starred: Bool { get set }
}

struct ParkCellConfigurator: ParkCellRepresentable {
    
    let imageURL: URL
    let name: String
    let adminArea: String
    let introduction: String
    var starred: Bool = false

    init(park: Park) {
        imageURL = park.imageURL
        name = park.parkName
        adminArea = park.adminArea
        introduction = park.intro
    }
}
