//
//  FakeMainViewPresenterDelegate.swift
//  MarvelComicsInfoTests
//
//  Created by Kenny Liao on 10/10/21.
//

import Foundation
@testable import MarvelComicsInfo

class FakeMainViewPresenterDelegate: MainViewPresenterDelegate {
    
    var showComicsListCommandCalled = false
    var errorCommandCalled = false
    
    func perform(_ command: MainViewCommand) {
        switch command {
        case .showComicsList(_):
            showComicsListCommandCalled = true
            
        case .error(_):
            errorCommandCalled = true
        }
    }
}
