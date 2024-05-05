//
//  ProductResponse.swift
//  jahids Shop
//
//  Created by jahidul islam on 5/5/24.
//

import Foundation

struct productResponse: Decodable {
    let id: Int
    let title: String
    let descripsion: String
    let price: Int
}
