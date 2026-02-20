//
//  FavoriteProtocol.swift
//  GalleryApp
//
//  Created by Valeria Badrakova on 1.02.26.
//

import Foundation

protocol FavoriteProtocol {
    func isFavorite(id: String) -> Bool
    func toggle(id: String)
}
