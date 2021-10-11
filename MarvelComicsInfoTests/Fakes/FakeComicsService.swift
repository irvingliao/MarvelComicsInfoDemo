//
//  FakeComicsService.swift
//  MarvelComicsInfoTests
//
//  Created by Kenny Liao on 10/10/21.
//

import Foundation
@testable import MarvelComicsInfo

class FakeComicsService: ComicsServiceProtocol {
    var getComicsListShouldReturnError = false
    var getComicDetailShouldReturnError = false
    
    func getComicsList(onComplete: @escaping (Result<ComicsList, Error>) -> Void) {
        if !getComicsListShouldReturnError {
            onComplete(.success(Fixtures.comicsList()))
        }
        else {
            onComplete(.failure(APIError.invalidData))
        }
    }
    
    func getComicDetail(comicId: String, onComplete: @escaping (Result<ComicDetail, Error>) -> Void) {
        if !getComicDetailShouldReturnError {
            onComplete(.success(Fixtures.comicDetail(comicId)))
        }
        else {
            onComplete(.failure(APIError.invalidData))
        }
    }
}
