//
//  NetworkService.swift
//  GalleryApp
//
//  Created by Valeria Badrakova on 31.01.26.
//

import Foundation

// URLSession - собственно URL
class NetworkService {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session 
    }
    
    func data(request: URLRequest) async throws -> (Data, URLResponse) {
        try await session.data(for: request)
    }
}
