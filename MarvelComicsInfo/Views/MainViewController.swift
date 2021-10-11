//
//  MainViewController.swift
//  MarvelComicsInfo
//
//  Created by Kenny Liao on 10/6/21.
//

import UIKit

class MainViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    let presenter: MainViewPresenter = {
        return MainViewPresenter(service: ComicsService())
    }()
    
    var comicsList: [ComicData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        
        presenter.delegate = self
        presenter.handle(event: .didLoad)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupUI() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        let comic = comicsList[indexPath.row]
        cell!.textLabel?.text = comic.title
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let data = comicsList[indexPath.row]
        self.navigationController?.pushViewController(ComicDetailViewController(comicId: "\(data.id)"), animated: true)
    }
}

extension MainViewController: MainViewPresenterDelegate {
    func perform(_ command: MainViewCommand) {
        switch command {
        case .showComicsList(let list):
            self.comicsList = list
            tableView.reloadData()
            
        case .error(_):
            self.showErrorAlert("Something is wrong, Please try again later.")
        }
    }
}
