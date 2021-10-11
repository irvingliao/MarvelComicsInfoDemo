//
//  ResponseDataModels.swift
//  MarvelComicsInfo
//
//  Created by Kenny Liao on 10/8/21.
//

import Foundation

struct ComicsResponse: Decodable {
    let data: ComicsList
}

struct ComicsList: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [ComicData]
}

struct ComicData: Decodable {
    let id: Int
    let title: String
    var description: String?
    let thumbnail: ImageData
}

struct ImageData: Decodable {
    let path: String
    let ext: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}

struct ComicDetailResponse: Decodable {
    let data: ComicDetail
}

struct ComicDetail: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [ComicData]
}
