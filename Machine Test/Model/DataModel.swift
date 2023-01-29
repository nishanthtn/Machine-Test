//
//  DataModel.swift
//  Machine Test
//
//  Created by Jaldee on 29/01/23.
//

import UIKit


struct DataModel    : Codable{
    var status      : Bool?
    var homeData    : [HomeData]?
}
struct HomeData     : Codable{
    var type        : String?
    var values      : [ValueData]?
}
struct ValueData    : Codable{
    var id          : Int?
    var name        : String?
    var image_url   : String?
    var banner_url  : String?
    var image       : String?
    var actual_price: String?
    var offer_price : String?
    var offer       : Float?
    var is_express  : Bool?
}
