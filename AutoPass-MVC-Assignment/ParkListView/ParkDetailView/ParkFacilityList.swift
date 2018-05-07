//
//  ParkFacilityList.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/7.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct ParkFacilityList: JSONDecodable {
    let offset: Int
    let limit: Int
    let items: [ParkFacility]
    
    public init(decodeUsing json: JSON) throws {
        let result = json["result"]
        guard
            let offset = result["offset"].int,
            let limit = result["limit"].int,
            let parkFacilityJSONItems = result["results"].array
            else { throw JSONDecodableError.parseError }
        
        self.offset = offset
        self.limit = limit
        self.items = try parkFacilityJSONItems.map{ try ParkFacility.init(decodeUsing: $0) }
    }
}
