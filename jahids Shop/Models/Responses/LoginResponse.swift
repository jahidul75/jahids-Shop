//
//  LoginResponse.swift
//  jahids Shop
//
//  Created by jahidul islam on 7/4/24.
//

import Foundation

struct LoginResponse: Decodable {
    
    let access_token: String?
    let refresh_token: String?
    let statusCode: Int?
    let massage: String?
}
