//
//  ErrorMessages.swift
//  GalleryApp
//
//  Created by Valeria Badrakova on 31.01.26.
//

import Foundation

enum ErrorMessages: LocalizedError {
    
    case badRequest   // 400
    case unAuthorized // 401
    case forbidden // 403
    case notFound // 404
    case noData // others 500 , 503
   
    var errorDescription: String? {
        switch self {
        case .badRequest:  return "400 - Bad Request. The request was unacceptable, often due to missing a required parameter"
        case .unAuthorized: return "401 - Unauthorized. Invalid Access Token"
        case .forbidden:   return "403 - Forbidden. Missing permissions to perform request"
        case .notFound:   return "404 - Not Found. The requested resource doesn’t exist"
        case .noData: return "500, 503 Something went wrong on our end"
        }
    
    }
    // -> ErrorMessages? - это возвращаемый тип ОКАК
    static func from(statusCode: Int) -> ErrorMessages? {
        // если успех — ошибки нет
        guard !(200...299).contains(statusCode) else {
            return nil
        }
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unAuthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 500, 503: return .noData
        default: return .noData
        }
    }
}
