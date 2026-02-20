//
//  State.swift
//  GalleryApp
//
//  Created by Valeria Badrakova on 1.02.26.
//

import Foundation
enum State {
    
    case initial
    case loading
    case loaded(items: [Photo], updatePhotos: Bool)
    case error(String)
    
}
