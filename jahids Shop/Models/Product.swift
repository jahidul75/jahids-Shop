//
//  Product.swift
//  jahids Shop
//
//  Created by jahidul islam on 12/3/24.
//

import Foundation

struct product {
    let id: Int
    let name: String
    let description: String
    let inStock: Bool
}

struct detail {
    let id: Int
    let name: String
    let descripsion: String
    let price: Int
    let inStock: Bool
}

struct allProducts: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var descripsion: String
    var price: Int
}
