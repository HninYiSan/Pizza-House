//
//  FoodData.swift
//  PizzaSampleApp
//
//  Created by Hnin Yi on 8/24/19.
//  Copyright © 2019 Hnin Yi San. All rights reserved.
//

import Foundation
class FoodData {
    var id:Int
    var foodname:String
    var foodprice:Int
    var foodpromo:Int
    init(id:Int,foodname:String,foodprice:Int,foodpromo:Int) {
        self.id = id
        self.foodname = foodname
        self.foodprice = foodprice
        self.foodpromo = foodpromo
    }
}
