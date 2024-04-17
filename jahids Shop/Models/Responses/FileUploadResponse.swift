//
//  FileUploadResponse.swift
//  jahids Shop
//
//  Created by jahidul islam on 16/4/24.
//

import Foundation

struct FileUploadeResponse: Decodable {
    let originalName: String
    let fileName: String
    let location: String
}
