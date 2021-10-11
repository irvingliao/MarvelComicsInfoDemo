//
//  MainViewModel.swift
//  MarvelComicsInfo
//
//  Created by Kenny Liao on 10/8/21.
//

import Foundation

enum MainViewEvent {
    case didLoad
    case willAppear
    case didAppear
}

enum MainViewCommand {
    case showComicsList([ComicData])
    case error(Error)
}

protocol MainViewPresenterDelegate: AnyObject {
    func perform(_ command: MainViewCommand)
}

class MainViewPresenter {
    
    weak var delegate: MainViewPresenterDelegate?
    let comicsService: ComicsServiceProtocol
    
    init(service: ComicsServiceProtocol) {
        comicsService = service
    }
    
    func handle(event: MainViewEvent) {
        switch event {
        case .didLoad:
            loadComics()
            
        default:
            break
        }
    }
    
    private func loadComics() {
        comicsService.getComicsList { [weak self] result in
            switch result {
            case .success(let list):
                self?.delegate?.perform(.showComicsList(list.results))
                
            case .failure(let err):
                self?.delegate?.perform(.error(err))
            }
        }
    }
}
