//
//  APIService.swift
//  FindingFalcone
//
//  Created by ROHIT MISHRA on 04/09/23.
//

import Foundation

struct Constants {
    static let baseURL = "https://findfalcone.geektrust.com/"
}

enum FindResponseType {
    case success(FindSuccessResponse)
    case failed(FindFailedResponse)
    case error(FindErrorResponse)
}


enum APIError: Error {
    case InvalidURL
    case FailedToFetchPlanetsData
    case FailedToFetchVehiclesData
    case FailedToDecode
    case InvalidResponse
    case NetworkError
    
}

final class APIService {
    static let shared = APIService()
    
    private init() {}
    
    public func getPlanets(completion: @escaping(Result<[Planet] , Error>) -> Void) {
        let endPoint = "planets"
        guard let url = URL(string: Constants.baseURL + endPoint) else {
            completion(.failure(APIError.InvalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data,
                  error == nil else {
                    completion(.failure(APIError.FailedToFetchPlanetsData))
                    return
                  }
            
            do {
                
                let result = try JSONDecoder().decode([Planet].self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(APIError.FailedToDecode))
            }
        }.resume()
    }
    
    public func getVehicles(completion: @escaping(Result<[Vehicle] , Error>) -> Void) {
        let endPoint = "vehicles"
        guard let url = URL(string: Constants.baseURL + endPoint) else {
            completion(.failure(APIError.InvalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data,
                  error == nil else {
                    completion(.failure(APIError.FailedToFetchVehiclesData))
                    return
                  }
            
            do {
                let result = try JSONDecoder().decode([Vehicle].self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(APIError.FailedToDecode))
            }
        }.resume()
    }
    
    public func getToken(completion: @escaping(Result<TokenResponse, Error>) -> Void) {
        let endPoint = "token"
        guard let url = URL(string: Constants.baseURL + endPoint) else {
            completion(.failure(APIError.InvalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  error == nil else {
                    completion(.failure(APIError.InvalidResponse))
                    return
                  }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                completion(.failure(APIError.NetworkError))
                return
            }
            
            do {
                let tokenData = try JSONDecoder().decode(TokenResponse.self, from: data)
                completion(.success(tokenData))
            } catch {
                completion(.failure(APIError.FailedToDecode))
            }
        }.resume()
    }
    
    public func getResult(selectedItems: FindRequestData, completion: @escaping(FindResponseType) -> Void) {
        let endPoint = "find"
        guard let url = URL(string: Constants.baseURL + endPoint) else {
            completion(.error(FindErrorResponse(error: "Invalid URL")))
            return
        }
        
        do {
            let requestData = try JSONEncoder().encode(selectedItems)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = requestData
            
            URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
               guard let data = data,
                     error == nil else {
                        completion(.error(FindErrorResponse(error: "Find falcon request failed")))
                         return
                     }
                
                let responseData = self?.handleFindResponseData(data: data)
                switch responseData {
                case .success(let successData):
                    completion(.success(successData))
                case .failed(let failedData):
                    completion(.failed(failedData))
                case .error(let errorData):
                    completion(.error(errorData))
                case .none:
                    completion(.error(FindErrorResponse(error: "Data might be nil !!")))
                }
            }.resume()
            
        } catch {
            completion(.error(FindErrorResponse(error: "Encoding Failed!!")))
        }
    }
    
    private func handleFindResponseData(data: Data) -> FindResponseType {
        do {
            let decoder = JSONDecoder()
            
            if let successResponse = try? decoder.decode(FindSuccessResponse.self, from: data) {
                return .success(successResponse)
            } else if let failedResponse = try? decoder.decode(FindFailedResponse.self, from: data) {
                return .failed(failedResponse)
            } else if let errorResponse = try? decoder.decode(FindErrorResponse.self, from: data) {
                return .error(errorResponse)
            }
        } catch {
            return .error(FindErrorResponse(error: error.localizedDescription))
        }
        return .error(FindErrorResponse(error: "Unkown Error !!"))
    }
}

