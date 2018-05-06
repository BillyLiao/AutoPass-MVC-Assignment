//
//  GetParkDetail.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/6.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

final public class GetParkDetail : NetworkRequest {
    public typealias ResponseType = ParkSpotList
    
    public var endpoint: String { return "" }
    public var method: HTTPMethod { return .get }
    public var encoding: ParameterEncoding { return URLEncoding.default }
    public var parameters: [String : Any]? { return ["q": name, "rid": "bf073841-c734-49bf-a97f-3757a6013812", "scope": "resourceAquire"]}
    
    private var name: String = ""
    public func perform(name: String) -> Promise<ResponseType> {
        self.name = name
        return networkClient.performRequest(self).then(execute: responseHandler)
    }
}
