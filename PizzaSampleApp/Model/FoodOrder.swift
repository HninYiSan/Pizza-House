//
//  FoodOrder.swift
//  PizzaSampleApp
//
//  Created by Hnin Yi on 9/1/19.
//  Copyright © 2019 Hnin Yi San. All rights reserved.
//

import Foundation
class FoodOrder {
    var oid:Int
    var odate:Double
    var ofid:String
    var totqty:Int
    var totamt:Int
    var tableno:Int
    var cashier:String
    
    init(oid:Int,odate:Double,ofid:String,totqty:Int,totamt:Int,tableno:Int,cashier:String) {
        self.oid = oid
        self.odate = odate
        self.ofid = ofid
        self.totqty = totqty
        self.totamt = totamt
        self.tableno = tableno
        self.cashier = cashier
    }
    
    func checkorder(<#parameters#>) -> <#return type#> {
        <#function body#>
    }
}
