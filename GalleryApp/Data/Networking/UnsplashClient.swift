//
//  UnsplashClient.swift
//  GalleryApp
//
//  Created by Valeria Badrakova on 31.01.26.
//

import Foundation
 
 final class UnsplashClient: ClientProtocol {
    private let network: NetworkService
    private let host: String
    private let accessKey: String
    private let decoder: Decoding
    private let errors: ErrorHandling

    init(
        network: NetworkService = NetworkService(),
        host: String = AppConfig.unsplashHost,
        accessKey: String = AppConfig.unsplashAccessKey,
        decoder: Decoding = Decoding(),
        errors: ErrorHandling = ErrorHandling()

    ) {
        self.network = network
        self.host = host
        self.accessKey = accessKey
        self.decoder = decoder
        self.errors = errors
    }
    
    func fetchPhotos(page: Int, perPage: Int = 30) async throws -> [Photo] {
        guard !accessKey.isEmpty else { throw ErrorMessages.unAuthorized }
        let requestBuilder = RequestBuilder.listPhotos(page: page, perPage: perPage, key: accessKey)
        let request = try requestBuilder.makeRequest(host: host)
         
        let (data, response) = try await network.data(request: request)
        try errors.responce(response: response)
    
        return try decoder.decode([Photo].self, from: data)
    }
}
