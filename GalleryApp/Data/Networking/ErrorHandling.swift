//
//  ErrorHandling.swift
//  GalleryApp
//
//  Created by Valeria Badrakova on 31.01.26.
//

import Foundation

 struct ErrorHandling {
     // ответ от сервера
     // если не HHTP -  выход, если ошибка - ловим
    func responce(response: URLResponse) throws {
        guard let http = response as? HTTPURLResponse else { return }
        
        if let error = ErrorMessages.from(statusCode: http.statusCode) {
            throw error
        }
    }
 }
