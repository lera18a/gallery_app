//
//  ClientProtocol.swift
//  GalleryApp
//
//  Created by Valeria Badrakova on 1.02.26.
//

import Foundation

protocol ClientProtocol {
    
    func fetchPhotos(page: Int, perPage: Int) async throws -> [Photo]
}
