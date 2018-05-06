//
//  Park.swift
//  KK-Assignment
//
//  Created by 廖慶麟 on 2018/4/10.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct Park: JSONDecodable {
    
    let id: String
    let parkName: String
    let openTime: String
    let imageURL: URL
    let intro: String
    let coordinate: (longitude: Float, latitude: Float)
    let adminArea: String

    public init(decodeUsing json: JSON) throws {
        guard
            let id = json["_id"].int,
            let parkName = json["ParkName"].string,
            let imageURLString = json["Image"].string,
            let imageURL = URL(string: imageURLString),
            let intro = json["Introduction"].string,
            let longitudeString = json["Longitude"].string,
            let longitude = Float(longitudeString),
            let latitudeString = json["Latitude"].string,
            let latitude = Float(latitudeString),
            let adminArea = json["AdministrativeArea"].string
        else { throw JSONDecodableError.parseError }
    
        self.id = "\(id)"
        self.parkName = parkName
        self.openTime = json["OpenTime"].string ?? ""
        self.imageURL = imageURL
        self.intro = intro
        self.coordinate = (longitude, latitude)
        self.adminArea = adminArea
    }
}
