//
//  ComicDetailViewPresenterTests.swift
//  MarvelComicsInfoTests
//
//  Created by Kenny Liao on 10/10/21.
//

import XCTest
@testable import MarvelComicsInfo

class ComicDetailViewPresenterTests: XCTestCase {
    
    var subject: ComicDetailViewPresenter!
    var service: FakeComicsService!

    override func setUp() {
        super.setUp()
        service = FakeComicsService()
        subject = ComicDetailViewPresenter(service: service)
    }
    
    func test_didLoadEventWithSuccessResponse() throws {
        let fakeDelegate = FakeComicDetailViewPresenterDelegate()
        subject.delegate = fakeDelegate
        subject.handle(event: .didLoad(comicId: "2"))
        
        XCTAssertTrue(fakeDelegate.showDataCommandCalled)
    }
    
    func test_didLoadEventWithFailedResponse() throws {
        let fakeDelegate = FakeComicDetailViewPresenterDelegate()
        service.getComicDetailShouldReturnError = true
        subject.delegate = fakeDelegate
        subject.handle(event: .didLoad(comicId: "4"))
        
        XCTAssertFalse(fakeDelegate.showDataCommandCalled)
    }
}
