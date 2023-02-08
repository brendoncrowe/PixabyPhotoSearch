//
//  Photo.swift
//  PixabyPhotoSearch
//
//  Created by Brendon Crowe on 2/8/23.
//

import Foundation

struct PhotoSearch:Codable {
    let hits: [Photo]
}

struct Photo: Codable {
    let largeImageURL: String
    let id: Int
    let user: String
    let likes: Int
    let views: Int
    let tags: String
    let downloads: Int
}
