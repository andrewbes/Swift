//
//  APIRequestProtocol.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 7/11/24.
//

import Alamofire

enum PerformRequestResult<T: Decodable> {
    case failure(CustomError?)
    case success(responseModel: T)
}

protocol RequestProtocol {
    func mockDataName() -> String?
    func method() -> HTTPMethod
    func fullApiPath() -> String
    func apiPath() -> String?
    func baseURL() -> String?
    func headers() -> HTTPHeaders?
    func parameters() -> [String : Any]?
    func rawData() -> Data?
    func encoding() -> ParameterEncoding
    func requiresAuth() -> Bool?
}

extension RequestProtocol {
    
    func mockDataName() -> String? {
        return nil
    }
    
    func method() -> HTTPMethod {
        return .post
    }
    
    func fullApiPath() -> String {
        return "\(baseURL() ?? "")\(apiPath() ?? "")"
    }
    
    func baseURL() -> String? {
        return Defines.serverURL
    }
    
    func apiPath() -> String? {
        return nil
    }
    
    func headers() -> HTTPHeaders? {
        return [HTTPHeader(name: "Content-Type", value: "application/json"),
                HTTPHeader(name: "Accept", value: "application/json")]
    }
    
    func parameters() -> [String : Any]? {
        return nil
    }
    
    func rawData() -> Data? {
        return nil
    }
    
    func encoding() -> ParameterEncoding {
        switch method() {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    func requiresAuth() -> Bool? {
        return false
    }
}

extension RequestProtocol {
    
    func performRequest<T: Decodable>(responseModelType: T.Type) async -> PerformRequestResult<T> {
        return await RequestManager.shared.performRequest(self, responseModelType: responseModelType)
    }
    
    func uploadMultipart<T: Decodable>(responseModelType: T.Type) async -> PerformRequestResult<T> {
        return await RequestManager.shared.uploadMultipart(self, responseModelType: responseModelType)
    }
    
    func getEncoder(convertToSnakeCase: Bool = true) -> JSONEncoder {
        let encoder = JSONEncoder()
        if convertToSnakeCase {
            encoder.keyEncodingStrategy = .convertToSnakeCase
        }
        return encoder
    }
}
