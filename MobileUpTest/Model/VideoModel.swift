//
//  VideoModel.swift
//  MobileUpTest
//
//  Created by Александр Андреев on 26.08.2024.
//

import Foundation
// Модели данных
struct VideoResponse: Decodable {
    var response: VideoItems
}

struct VideoItems: Decodable {
    var items: [Video]
}

struct Video: Decodable {
    var dateVideo: Int
    var descriptionVideo: String
    var titleVideo: String
    var urlPlayer: String
    var imagePreview: [ImagePreview]
    
    
    enum CodingKeys: String, CodingKey {
        case dateVideo = "adding_date"
        case descriptionVideo = "description"
        case titleVideo = "title"
        case urlPlayer = "player"
        case imagePreview = "image"
    }
}

struct ImagePreview: Decodable {
    var height: Int
    var width: Int
    var url: String
}

