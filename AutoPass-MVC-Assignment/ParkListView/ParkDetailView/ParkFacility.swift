//
//  ParkFacility.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/7.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct ParkFacility: JSONDecodable {
    
    let id: String
    let name: String
    
    public init(decodeUsing json: JSON) throws {
        guard
            let id = json["_id"].int,
            let name = json["facility_name"].string
        else { throw JSONDecodableError.parseError }
        
        self.id = "\(id)"
        self.name = name
    }
}
