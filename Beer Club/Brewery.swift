//
//  Brewery.swift
//  Beer Club
//
//  Created by Schvindt, Lucas S on 4/18/16.
//  Copyright © 2016 TTSLucas. All rights reserved.
//

import Foundation
import Firebase

struct Brewery {
    let id: String
    let name: String
    let nickname: String
    let logo: String
    let description: String
    let tourTime: String
    let addressLink: String
    
    init(id:String, name:String, nickname:String, logo:String, description:String, tourTime:String, addressLink:String) {
        self.id = id
        self.name = name
        self.nickname = nickname
        self.logo = logo
        self.description = description
        self.tourTime = tourTime
        self.addressLink = addressLink
    }
    
    init(snapshot: FDataSnapshot) {
        self.id = snapshot.key
        self.name = snapshot.value["name"] as! String
        self.nickname = snapshot.value["nickname"] as! String
        self.logo = snapshot.value["logo"] as? String ?? "beer"
        self.description = snapshot.value["description"] as! String
        self.tourTime = snapshot.value["tourTime"] as! String
        self.addressLink = snapshot.value["addressLink"] as? String ?? ""
    }
}
