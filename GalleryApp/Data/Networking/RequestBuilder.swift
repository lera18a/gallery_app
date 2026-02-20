//
//  RequestBuilder.swift
//  GalleryApp
//
//  Created by Valeria Badrakova on 1.02.26.
//

import Foundation

enum RequestBuilder {
    case listPhotos(page: Int, perPage: Int, key: String)
    
    func makeRequest(host: String) throws -> URLRequest {
        switch self {
        case let .listPhotos(page, perPage, key):
            
            guard var components = URLComponents(string: host + "/photos") else {
                throw URLError(.badURL)
            }
            
            components.queryItems = [
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "per_page", value: "\(perPage)"),
                URLQueryItem(name: "client_id", value: key)
            ]
            
            guard let url = components.url else {
                throw URLError(.badURL)
            }
            return URLRequest(url: url)
        }
    }
}
