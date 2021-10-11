//
//  ComicsService.swift
//  MarvelComicsInfo
//
//  Created by Kenny Liao on 10/7/21.
//

import Foundation

public class ComicsService: ComicsServiceProtocol {
    
    enum Constants {
        static let baseURL = "https://gateway.marvel.com"
        static let pathComicsList = "/v1/public/comics"
        static let pathComicDetail = "/v1/public/comics/"
    }
    
    let apiKey: String
    let secret: String
    
    init() {
        guard let config = Bundle.main.infoDictionary?["MarvelConfig"] as? [AnyHashable: String],
              let key = config["apiKey"],
              let sec = config["secret"] else {
            self.apiKey = ""
            self.secret = ""
            return
        }
        
        self.apiKey = key
        self.secret = sec
    }
    
    func getComicsList(onComplete: @escaping (Result<ComicsList, Error>) -> Void ) {
        let ts = String(format: "%f", Date().timeIntervalSince1970)
        let hash = MD5(string: "\(ts)\(secret)\(apiKey)")
        
        let req = ApiClient.shared.createRequest(
            url: URL(string: Constants.baseURL+Constants.pathComicsList)!,
            method: .get,
            headers: nil,
            params: [
                "format": "comic",
                "formatType": "comic",
                "ts": ts,
                "apikey": apiKey,
                "hash": hash
            ]
        )
        
        ApiClient.shared.sendReq(req) { (result: Result<ComicsResponse, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    onComplete(.success(response.data))
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                    onComplete(.failure(error))
                }
            }
        }
    }
    
    func getComicDetail(comicId: String, onComplete: @escaping (Result<ComicDetail, Error>) -> Void ) {
        
        let ts = String(format: "%f", Date().timeIntervalSince1970)
        let hash = MD5(string: "\(ts)\(secret)\(apiKey)")
        
        let req = ApiClient.shared.createRequest(
            url: URL(string: Constants.baseURL+Constants.pathComicDetail+comicId)!,
            method: .get,
            headers: nil,
            params: [
                "ts": ts,
                "apikey": apiKey,
                "hash": hash
            ]
        )
        
        ApiClient.shared.sendReq(req) { (result: Result<ComicDetailResponse, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    onComplete(.success(response.data))
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                    onComplete(.failure(error))
                }
            }
        }
    }    
}
