//
//  AlbumResponse.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 25.08.2024.
//

import Foundation
struct AlbumResponse: Codable {
    let response: Album
}


struct Album: Codable {
    let count: Int
    let items: [PhotoModel]
}

struct PhotoModel: Codable {
    let date: Int
    let id: Int
    let sizes: [Size]
}

struct Size: Codable {
    let type: String
    let url: String
}
