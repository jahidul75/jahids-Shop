//
//  File.swift
//  jahids Shop
//
//  Created by jahidul islam on 29/5/24.
//

import Foundation
import SwiftyJSON

class CartManager: ObservableObject {
    var products: [JSON] = []
    @Published private(set) var totalPrice: Int = 0
    
    func addToCart(product: JSON) {
        products.append(product)
        //totalPrice += product.price
    }
    
    func removeFromCart(product: allProducts) {
        //products = products.filter { $0.id != product.id}
        //totalPrice -= product.price
    }
}
