//
//  ProfileResponse.swift
//  jahids Shop
//
//  Created by jahidul islam on 10/4/24.
//

import Foundation


struct profileResponse: Decodable {
    let id: Int
    let email: String
    let name: String
    let role: String
    let avatar: String
}
