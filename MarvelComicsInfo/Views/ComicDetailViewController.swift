//
//  ComicDetailViewController.swift
//  MarvelComicsInfo
//
//  Created by Kenny Liao on 10/10/21.
//

import UIKit

class ComicDetailViewController: UIViewController {
    
    let presenter: ComicDetailViewPresenter = {
        return ComicDetailViewPresenter(service: ComicsService())
    }()
    
    let detailView: ComicDetailView = {
        return ComicDetailView(frame: CGRect.zero)
    }()
    
    var comicID: String = ""
    
    init(comicId: String) {
        self.comicID = comicId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view = detailView
        presenter.delegate = self
        presenter.handle(event: .didLoad(comicId: comicID))
    }
}

extension ComicDetailViewController: ComicDetailViewPresenterDelegate {
    func perform(_ command: ComicDetailViewCommand) {
        switch command {
        case .showData(let data):
            detailView.update(comicData: data)
            
        case .error(_):
            self.showErrorAlert("Something is wrong, Please try again later.")
        }
    }
}
