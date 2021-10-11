//
//  MainViewPresenterTests.swift
//  MarvelComicsInfoTests
//
//  Created by Kenny Liao on 10/10/21.
//

import XCTest
@testable import MarvelComicsInfo

class MainViewPresenterTests: XCTestCase {

    var subject: MainViewPresenter!
    var service: FakeComicsService!
    
    override func setUp() {
        super.setUp()
        service = FakeComicsService()
        subject = MainViewPresenter(service: service)
    }

    func test_didLoadEventWithSuccessResponse() throws {
        let fakeDelegate = FakeMainViewPresenterDelegate()
        subject.delegate = fakeDelegate
        subject.handle(event: .didLoad)
        
        XCTAssertTrue(fakeDelegate.showComicsListCommandCalled)
    }
    
    func test_didLoadEventWithFailedResponse() throws {
        let fakeDelegate = FakeMainViewPresenterDelegate()
        service.getComicsListShouldReturnError = true
        subject.delegate = fakeDelegate
        subject.handle(event: .didLoad)
        
        XCTAssertFalse(fakeDelegate.showComicsListCommandCalled)
    }
}
