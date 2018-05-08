//
//  FavoriteParkRealmObject.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/7.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import Foundation

final class FavoriteParkRealmObject: RealmObject {
    @objc dynamic var name: String = ""
    @objc dynamic var openTime: String = ""
    @objc dynamic var imageURLString: String = ""
    @objc dynamic var intro: String = ""
    @objc dynamic var latitude: Float = 0
    @objc dynamic var longitude: Float = 0
    @objc dynamic var adminArea: String = ""
    @objc dynamic var location: String = ""
    @objc dynamic var type: String = ""
    
    convenience init(_ park: Park) {
        self.init()

        self.id = park.id
        self.name = park.parkName
        self.openTime = park.openTime
        self.imageURLString = park.imageURL.absoluteString
        self.intro = park.intro
        self.latitude = park.coordinate.latitude
        self.longitude = park.coordinate.longitude
        self.adminArea = park.adminArea
        self.location = park.location
        self.type = park.type
    }
}
