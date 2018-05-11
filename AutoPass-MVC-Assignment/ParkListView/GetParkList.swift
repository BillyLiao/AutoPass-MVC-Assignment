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
    
    public var endpoint: String { return "" }
    public var method: HTTPMethod { return .get }
    public var encoding: ParameterEncoding { return URLEncoding.default }
    public var parameters: [String : Any]? { return ["id": "a132516d-d2f3-4e23-866e-27e616b3855a", "rid": "8f6fcb24-290b-461d-9d34-72ed1b3f51f0", "limit": 15, "offset": offset, "scope": "resourceAquire"]}
    
    private var offset: Int = 0
    public func perform(offset: Int = 0) -> Promise<ResponseType> {
        self.offset = offset
        return networkClient.performRequest(self).then(execute: responseHandler)
    }
}
