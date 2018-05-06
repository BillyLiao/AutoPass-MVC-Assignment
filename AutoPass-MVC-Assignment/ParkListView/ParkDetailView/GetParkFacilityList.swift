//
//  GetParkFacilityList.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/7.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

final public class GetParkFacilityList: NetworkRequest {
    public typealias ResponseType = ParkFacilityList
    
    public var endpoint: String { return "" }
    public var method: HTTPMethod { return .get }
    public var encoding: ParameterEncoding { return URLEncoding.default }
    public var parameters: [String : Any]? { return ["q": name, "rid": "97d0cf5c-dc1f-4b5e-8d02-a07e7cc82db7", "id": "11b63969-a337-4f3e-b61c-954ba9ed9937", "scope": "resourceAquire"]}
    
    private var name: String = ""
    public func perform(name: String) -> Promise<ResponseType> {
        self.name = name
        return networkClient.performRequest(self).then(execute: responseHandler)
    }
}
