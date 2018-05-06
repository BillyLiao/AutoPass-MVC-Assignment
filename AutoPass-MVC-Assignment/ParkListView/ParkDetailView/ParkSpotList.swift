//
//  ParkSpotList.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/6.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct ParkSpotList: JSONDecodable {
    let offset: Int
    let limit: Int
    let items: [ParkSpot]
    
    public init(decodeUsing json: JSON) throws {
        print(json)
        let result = json["result"]
        guard
            let offset = result["offset"].int,
            let limit = result["limit"].int,
            let parkSpotJSONItems = result["results"].array
            else { throw JSONDecodableError.parseError }
        
        self.offset = offset
        self.limit = limit
        self.items = try parkSpotJSONItems.map{ try ParkSpot.init(decodeUsing: $0) }
    }
}
