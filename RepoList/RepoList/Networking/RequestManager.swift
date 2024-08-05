//
//  NetworkManager.swift
//  ToDoList
//
//  Created by Andrii Bezkorovainyi on 7/11/24.
//

import Foundation
import Alamofire

class RequestManager : StoredService {

    static let shared = RequestManager()
    let tokenService: TokensService = ServiceHolder.shared.get()
    
    //weak var delegate: RequestManagerDelegate?
    
    private let reachabilityManager = NetworkReachabilityManager()
    private var isInternetAvailable: Bool? = nil
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    init() {
        AF.session.configuration.timeoutIntervalForRequest = 15.0
        startInternetStatusListen()
    }
    
    private func startInternetStatusListen() {
        reachabilityManager?.startListening(onUpdatePerforming: { [weak self] status in
            print("startInternetStatusListen \(status)")
            self?.isInternetAvailable = (status == .reachable(.cellular) || status == .reachable(.ethernetOrWiFi))
        })
    }
    
    private func checkForInternetAvailability() -> Bool {
        return isInternetAvailable ?? false
    }
    
    func cancelAllRequests() {
        AF.cancelAllRequests()
    }
    
    func performRequest<T: Decodable>(_ requestItem: RequestProtocol, responseModelType: T.Type) async -> PerformRequestResult<T> {
        guard checkForInternetAvailability() else {
            return .failure(CustomError.offlineError())
        }
        
        if let mockDataFilename = requestItem.mockDataName() {
            return await returnDataFromMockup(mockDataFilename: mockDataFilename, responseModelType: responseModelType)
        }
        
        do {
            let urlRequest = try prepareURLRequest(from: requestItem)

            let dataResponse = await AF.request(urlRequest).serializingData().response

            guard let statusCode = dataResponse.response?.statusCode, (200...299).contains(statusCode) else {
                if let responseData = dataResponse.data, let responseString = String(data: responseData, encoding: .utf8) {
                    print("Invalid response status code: \(dataResponse.response?.statusCode ?? -1)")
                    print("Response Data: \(responseString)")
                }
                return .failure(CustomError(message: "Invalid response status code: \(dataResponse.response?.statusCode ?? -1)"))
            }

            let decodedResponse = try jsonDecoder.decode(responseModelType, from: dataResponse.data ?? Data())

            print("Response: \(decodedResponse)")
            return .success(responseModel: decodedResponse)
        } catch {
            print("performRequest \(error.localizedDescription)")
            return .failure(CustomError(message: error.localizedDescription))
        }
    }
    
    func uploadMultipart<T: Decodable>(_ requestItem: RequestProtocol, responseModelType: T.Type) async -> PerformRequestResult<T> {
        guard checkForInternetAvailability() else {
            return .failure(CustomError.offlineError())
        }
        
        guard let fullPathUrl = URL(string: requestItem.fullApiPath()) else {
            return .failure(.somethingWentWrongError())
        }
        
        do {
            let response = try await AF.upload(multipartFormData: { multipartFormData in
                requestItem.parameters()?.forEach {
                    if let multipartFormDataModel = $0.value as? MultipartFormDataModel {
                        multipartFormData.append(multipartFormDataModel.data, withName: multipartFormDataModel.fieldName, fileName: multipartFormDataModel.fileName, mimeType: multipartFormDataModel.mimeType)
                    }
                }
            }, to: fullPathUrl, method: requestItem.method(), headers: prepareHeaders(for: requestItem)).serializingDecodable(responseModelType, decoder: jsonDecoder).value
            return .success(responseModel: response)
        } catch {
            print("uploadMultipart \(error.localizedDescription)")
            return .failure(CustomError(message: error.localizedDescription))
        }
    }
    
    private func prepareURLRequest(from requestItem: RequestProtocol) throws -> URLRequest {
        guard let fullPathUrl = URL(string: requestItem.fullApiPath()) else {
            throw CustomError.somethingWentWrongError()
        }
        
        var request = try URLRequest(url: fullPathUrl, method: requestItem.method(), headers: prepareHeaders(for: requestItem))
        request = try requestItem.encoding().encode(request, with: requestItem.parameters())
        
        if let rawData = requestItem.rawData() {
            request.httpBody = rawData
        }
        
        return request
    }
    
    private func prepareHeaders(for requestItem: RequestProtocol) -> HTTPHeaders {
        var headers = requestItem.headers() ?? [:]
        
        if requestItem.requiresAuth() ?? false, let token = tokenService.githubToken {
            headers["Authorization"] = "token \(token)"
        }
        
        return headers
    }
}

// MARK: - Private Functions
extension RequestManager {
    private func returnDataFromMockup<T: Decodable>(mockDataFilename: String, responseModelType: T.Type) async ->PerformRequestResult<T> {
        guard let path = Bundle.main.path(forResource: mockDataFilename, ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            return .failure(CustomError(message: "Error on parse data from bundle"))
        }
        return await parseResponse(data: data, responseModelType: responseModelType)
    }
    
    private func parseResponse<T: Decodable>(data: Data?, responseModelType: T.Type) async -> PerformRequestResult<T> {
        guard let jsonData = data else {
            return .failure(CustomError.somethingWentWrongError())
        }
        
        do {
            let responseModel = try jsonDecoder.decode(responseModelType, from: jsonData)
            return .success(responseModel: responseModel)
        } catch {
            if let stringValue = String(bytes: jsonData, encoding: .utf8) {
                debugPrint("parseJSON \(stringValue)")
            }
            if let decError = error as? DecodingError, let errorString = decError.errorString {
                return .failure(CustomError(message: errorString))
            }
            debugPrint("parseJSON \(error)")
            return .failure(CustomError.somethingWentWrongError())
        }
    }
}

