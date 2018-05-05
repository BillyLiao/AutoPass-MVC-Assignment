//
//  GetParkList.swift
//  KK-Assignment
//
//  Created by 廖慶麟 on 2018/4/10.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire
import SwiftyJSON

public class GetParkList : NetworkRequest {
    public typealias ResponseType = ParkList
    
    public var endpoint: String { return "/apiAccess?scope=resourceAquire&rid=bf073841-c734-49bf-a97f-3757a6013812" }
    public var method: HTTPMethod { return .get }
    
    public func perform() -> Promise<ResponseType> {
        return networkClient.performRequest(self).then(execute: responseHandler)
    }
}
