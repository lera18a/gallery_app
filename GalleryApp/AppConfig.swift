//
//  AppConfig.swift
//  GalleryApp
//
//  Created by Valeria Badrakova on 31.01.26.
//

import Foundation

enum AppConfig {
    static var unsplashHost: String {
        Bundle.main.object(forInfoDictionaryKey: "UNSPLASH_HOST") as? String ?? "https://api.unsplash.com"
    }

    static var unsplashAccessKey: String {
        Bundle.main.object(forInfoDictionaryKey: "UNSPLASH_ACCESS_KEY") as? String ?? ""
    }
}
