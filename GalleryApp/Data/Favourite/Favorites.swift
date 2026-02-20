//
//  Favorites.swift
//  GalleryApp
//
//  Created by Valeria Badrakova on 1.02.26.
//

import Foundation

class Favorites: FavoriteProtocol {
    private let key = "id"
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func isFavorite(id: String) -> Bool {
        allId().contains(id)
    }
    
    func toggle(id: String) {
        var ids = allId()
        if ids.contains(id) {
            ids.remove(id)
        } else {
            ids.insert(id)
        }
        defaults.set(Array(ids), forKey: key)
        }
    
    func allId() -> Set<String> {
        Set(defaults.stringArray(forKey: key) ?? [] )
    }
}
