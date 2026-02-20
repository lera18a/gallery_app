//
//  photo.swift
//  GalleryApp
//
//  Created by Valeria Badrakova on 31.01.26.
//

import Foundation

struct Photo: Decodable {

    let id: String
    let description: String?
    let altDescription: String?
    let urls: Urls
    
    struct Urls: Decodable {
        let regular: URL
        let small: URL
    }
    // для переименования полей - CodingKey
    enum CodingKeys: String, CodingKey {
        case id
        case description
        case altDescription = "alt_description"
        case urls
    }
}
