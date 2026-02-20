//
//  Decoding.swift
//  GalleryApp
//
//  Created by Valeria Badrakova on 31.01.26.
//

import Foundation

struct Decoding {
    private let decoder: JSONDecoder = JSONDecoder()
    // встроенный метод
    // парсим JSon
    func decode<T: Decodable>(_ type: T.Type, from jsonData: Data) throws -> T {
         try decoder.decode(T.self, from: jsonData)
     }
}
