//
//  ComicDetailViewPresenter.swift
//  MarvelComicsInfo
//
//  Created by Kenny Liao on 10/10/21.
//

import Foundation

enum ComicDetailViewEvent {
    case didLoad(comicId: String)
    case willAppear
    case didAppear
}

enum ComicDetailViewCommand {
    case showData(ComicData)
    case error(Error)
}

protocol ComicDetailViewPresenterDelegate: AnyObject {
    func perform(_ command: ComicDetailViewCommand)
}

class ComicDetailViewPresenter {
    
    weak var delegate: ComicDetailViewPresenterDelegate?
    let comicsService: ComicsServiceProtocol
    
    init(service: ComicsServiceProtocol) {
        comicsService = service
    }
    
    func handle(event: ComicDetailViewEvent) {
        switch event {
        case .didLoad(let comicId):
            loadComicDetail(comicId: comicId)
            
        default:
            break
        }
    }
    
    private func loadComicDetail(comicId: String) {
        comicsService.getComicDetail(comicId: comicId) { [weak self] result in
            switch result {
            case .success(let detail):
                guard let data = detail.results.first else {
                    self?.delegate?.perform(.error(APIError.invalidData))
                    return
                }
                self?.delegate?.perform(.showData(data))
                
            case .failure(let err):
                self?.delegate?.perform(.error(err))
            }
        }
    }
}
