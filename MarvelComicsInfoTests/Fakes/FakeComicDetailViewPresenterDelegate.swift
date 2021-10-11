//
//  FakeComicDetailViewPresenterDelegate.swift
//  MarvelComicsInfoTests
//
//  Created by Kenny Liao on 10/10/21.
//

import Foundation
@testable import MarvelComicsInfo

class FakeComicDetailViewPresenterDelegate: ComicDetailViewPresenterDelegate {
    
    var showDataCommandCalled = false
    var errorCommandCalled = false
    
    func perform(_ command: ComicDetailViewCommand) {
        switch command {
        case .showData(_):
            showDataCommandCalled = true
            
        case .error(_):
            errorCommandCalled = true
        }
    }
}
