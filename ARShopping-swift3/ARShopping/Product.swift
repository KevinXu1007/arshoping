//
//  Product.swift
//  Smartshop
//
//  Created by Shunchao Wang on 1/26/2016.
//  Copyright © 2016 swang. All rights reserved.
//

import Foundation

class Category {
    var id: Int = 0
    var name: String = ""
}

class Product {
    var id: Int = 0
    var image: String = ""
    var market_price: Double = 0.0
    var shop_price: Double = 0.0
    var name: String = ""
    var description: String = ""
}

class CartItem {
    var product: Product = Product()
    var quantity: Int = 0
    var subTotal: Double = 0.0
}
