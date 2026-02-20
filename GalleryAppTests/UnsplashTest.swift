//
//  UnsplashTest.swift
//  GalleryAppTests
//
//  Created by Valeria Badrakova on 31.01.26.
//

import XCTest
@testable import GalleryApp
class UnsplashTest: XCTestCase {
    private var host: String = "https://api.unsplash.com"
    private var  key: String = Bundle(for: UnsplashTest.self).object(forInfoDictionaryKey: "UNSPLASH_ACCESS_KEY") as? String ?? ""

func testList() async throws {
    let client = UnsplashClient(network: NetworkService(), host: host, accessKey: key)
    let photos = try await client.fetchPhotos(page: 1, perPage: 10)
    print(photos)
    XCTAssertFalse(photos.isEmpty)
    XCTAssertGreaterThan(photos.count, 1)
    XCTAssertFalse(photos[0].id.isEmpty)
    }
}

