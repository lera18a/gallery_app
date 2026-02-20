//
//  StateManagement.swift
//  GalleryApp
//
//  Created by Valeria Badrakova on 1.02.26.

import Foundation
@MainActor
// вся логика
class ViewModel {
    // текущее состояние
    private(set) var state: State = .initial {
        didSet {
            // меняется - уведомляем контроллер
            onStateChange?(state)
        }
    }
    // Callback для уведомления ViewController
    var onStateChange: ((State) -> Void)?
    
    private let client: ClientProtocol
    private var page = 1
    private var isLoading = false
    private var photos: [Photo] = []
    
    init(client: ClientProtocol = UnsplashClient()) {
        self.client = client
    }
  
    func initial() {
        page = 1
        photos = []
        isLoading = false
        load(page: page, loadNextPage: false)
    }
    
    func loadNextPage(index: Int) {
        guard case .loaded(let items, let updatePhotos) = state else {
            return
        }
        guard !updatePhotos else {
            return
        }
        if index >= items.count - 6 {
            page += 1
            load(page: page, loadNextPage: true)
        }
    }
    
    func load(page: Int, loadNextPage: Bool) {
        guard !isLoading else { return }
        isLoading = true
        
        if !loadNextPage {
            state = .loading
        } else if case .loaded(let items, _) = state {
            state = .loaded(items: items, updatePhotos: true )
        }

        Task {
            do {
                let new = try await client.fetchPhotos(page: page, perPage: 30)
                photos.append(contentsOf: new)
                state = .loaded(items: photos, updatePhotos: false)
            } catch {
                state = .error(error.localizedDescription)
            }
            isLoading = false
        }
    }
   
}
