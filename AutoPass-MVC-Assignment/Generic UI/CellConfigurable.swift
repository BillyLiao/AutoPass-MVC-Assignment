//
//  CellConfigurable.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/5.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import Foundation

protocol CellConfigurable: class {
    associatedtype Configurator
    var cellConfigurator: Configurator? { get set }
}
