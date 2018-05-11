//
//  ParkList.swift
//  KK-Assignment
//
//  Created by 廖慶麟 on 2018/4/10.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct ParkList: JSONDecodable {
    let offset: Int
    let limit: Int
    let count: Int
    let sort: String
    let items: [Park]
    
    public init(decodeUsing json: JSON) throws {
        let result = json["result"]
        guard
            let offset = result["offset"].int,
            let limit = result["limit"].int,
            let count = result["count"].int,
            let sort = result["sort"].string,
            let parkJSONItems = result["results"].array
        else { throw JSONDecodableError.parseError }
        
        self.offset = offset
        self.limit = limit
        self.count = count
        self.sort = sort
        self.items = try parkJSONItems.map{ try Park.init(decodeUsing: $0) }
    }
}
