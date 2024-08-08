//
//  ReelsModel.swift
//  DemoVideoPlayer
//
//  Created by PujaRaj on 03/08/24.
//

import Foundation


struct VideoResponse: Codable {
    let reels: [VideoSection]
}

struct VideoSection: Codable {
    let arr: [VideoModel]
}

struct VideoModel: Codable {
    let id: String
    let video: URL
    let thumbnail: URL

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case video
        case thumbnail
    }
}


























/*struct Video: Codable {
    let id: String
    let videoURL: URL
    let thumbnailURL: URL

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case videoURL = "video"
        case thumbnailURL = "thumbnail"
    }
}

// Define the Reel data model
struct Reel: Codable {
    let arr: [Video]
}

// Define the ReelsContainer data model
struct ReelsContainer: Codable {
    let reels: [Reel]
}*/




