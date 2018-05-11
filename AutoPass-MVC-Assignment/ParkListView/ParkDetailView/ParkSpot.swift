//
//  ParkSpot.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/6.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct ParkSpot: JSONDecodable {
    
    let id: String
    let parkName: String
    let name: String
    let openTime: String
    let imageURL: URL
    let intro: String
    
    public init(decodeUsing json: JSON) throws {
        guard
            let id = json["_id"].int,
            let parkName = json["ParkName"].string,
            let name = json["Name"].string,
            let imageURLString = json["Image"].string,
            let imageURL = URL(string: imageURLString),
            let intro = json["Introduction"].string
        else { throw JSONDecodableError.parseError }
        
        self.id = "\(id)"
        self.parkName = parkName
        self.name = name
        self.openTime = json["OpenTime"].string ?? ""
        self.imageURL = imageURL
        self.intro = intro
    }
}
