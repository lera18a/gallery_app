//
//  DetailViewModel.swift
//  GalleryApp
//
//  Created by Valeria Badrakova on 1.02.26.
//

import Foundation

@MainActor
final class DetailViewModel {
    private let favorites: FavoriteProtocol

    private let photos: [Photo]
    private(set) var index: Int {
        didSet { onChange?(current) }
    }

    var onChange: ((Photo) -> Void)?

    init(photos: [Photo], startIndex: Int, favorites: FavoriteProtocol = Favorites()) {
        self.photos = photos
        self.index = startIndex
        self.favorites = favorites
    }

    var current: Photo {
        photos[index]
    }

    func start() {
        onChange?(current)
    }

    func next() {
        guard index < photos.count - 1 else { return }
        index += 1
    }

    func previous() {
        guard index > 0 else { return }
        index -= 1
    }
    
    func toggleFavorite() {
        favorites.toggle(id: current.id)
        onChange?(current)
    }
    
    func isCurrentFavorite() -> Bool {
        favorites.isFavorite(id: current.id)
    }
}
