//
//  ApiClient.swift
//  MarvelComicsInfo
//
//  Created by Kenny Liao on 10/7/21.
//

import Foundation

enum ReqMethod: Int {
    case get = 0
    case post
}

enum APIError: Error {
    case statusCode
    case decoding
    case invalidData
    case invalidURL
    case other(Error)
    
    static func map(_ error: Error) -> APIError {
        return (error as? APIError) ?? .other(error)
    }
}

class ApiClient {
    
    static let instance = ApiClient()
    let session: URLSession
    
    typealias Completion<T: Decodable> = (Result<T, Error>) -> Void
    
    class var shared: ApiClient {
        return instance
    }
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.httpCookieAcceptPolicy = .always
        configuration.httpShouldSetCookies = true
        session = URLSession(configuration: configuration)
    }
    
    func createRequest(
        url: URL,
        method: ReqMethod,
        headers: [String: String]?,
        params: [String: Any]?,
        data: Data? = nil
    ) -> URLRequest {
        
        var req: URLRequest
        var postBody = true

        switch method {
        case .get:
            if let queryParams = params as? [String: String],
               var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) {
                if urlComponents.queryItems == nil {
                    urlComponents.queryItems = queryParams.map { URLQueryItem(name: $0, value: $1) }
                }
                else {
                    urlComponents.queryItems?.append(contentsOf: queryParams.map { URLQueryItem(name: $0, value: $1) })
                }
                req = URLRequest(url: urlComponents.url ?? url)
                postBody = false
            }
            else {
                req = URLRequest(url: url)
            }
            req.httpMethod = "GET"

        case .post:
            req = URLRequest(url: url)
            req.httpMethod = "POST"
        }

        if postBody {
            if let params = params {
                guard let postData = try? JSONSerialization.data(withJSONObject: params, options: []) else {
                    fatalError("APIError.invalidBody")
                }
                req.httpBody = postData
            }
            else if let data = data {
                req.httpBody = data
            }
        }

        if let headers = headers {
            req.allHTTPHeaderFields = headers
        }
        
        return req
    }
    
    func sendReq<T: Decodable>(_ request: URLRequest, _ onComplete: @escaping Completion<T>) {
        print(request.url!)
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    onComplete(.failure(APIError.other(error!)))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    onComplete(.failure(APIError.invalidData))
                    return
                }

                let statusCode = httpResponse.statusCode
                var responseString = ""
                guard let data = data else {
                    onComplete(.failure(APIError.invalidData))
                    return
                }
                responseString = String(data: data, encoding: .utf8) ?? ""

                if 400..<600 ~= statusCode {
                    var reason = "\(httpResponse.statusCode) "
                    if statusCode == 400 {
                        reason += "Bad Request:"
                    }
                    else if statusCode == 401 {
                        reason += "Unauthorized:"
                    }
                    else if statusCode == 403 {
                        reason += "Resource forbidden:"
                    }
                    else if statusCode == 404 {
                        reason += "Resource not found:"
                    }
                    else if statusCode == 409 {
                        reason += "Error: "
                    }
                    else if 405..<500 ~= statusCode {
                        reason += "client error:"
                    }
                    else if 500..<600 ~= statusCode {
                        reason += "server error:"
                    }
                    reason += " \(responseString)"
                    onComplete(
                        .failure(
                            APIError.other(
                                NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: reason])
                            )
                        )
                    )
                    return
                }
                
                if let results = try? JSONDecoder().decode(T.self, from: data) {
                    onComplete(.success(results))
                }
                else {
                    onComplete(.failure(APIError.decoding))
                }
            }

        }.resume()
    }
    
}
