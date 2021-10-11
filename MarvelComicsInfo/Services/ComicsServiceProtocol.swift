//
//  ComicsServiceProtocol.swift
//  MarvelComicsInfo
//
//  Created by Kenny Liao on 10/10/21.
//

import Foundation

protocol ComicsServiceProtocol {
    func getComicsList(onComplete: @escaping (Result<ComicsList, Error>) -> Void )
    func getComicDetail(comicId: String, onComplete: @escaping (Result<ComicDetail, Error>) -> Void )
}
