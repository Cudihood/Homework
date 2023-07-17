//
//  TableViewController.swift
//  Practic15
//
//  Created by Даниил Циркунов on 27.02.2023.
//

import UIKit
import SnapKit
class TableViewController: UITableViewController{

    var stringURL: String = ""
    var dataCell: [CustomTableViewCellModel] = []
    var service = Service()
    private var images: [UIImage] = []
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search Here....."
        searchBar.sizeToFit()
        return searchBar
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        self.view.backgroundColor = .white
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
    }
    
    private func setupViews(){
        tableView.tableHeaderView = searchBar
        searchBar.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(view.snp.width)
        }
        tableView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCell.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? CustomTableViewCell
        let viewModel = dataCell[indexPath.row]
        cell?.configure(viewModel)
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

    // MARK: - Search

extension TableViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        stringURL = "https://imdb-api.com/API/Search/k_d5w2w7cy/\(searchBar.text ?? "" )"
        self.tableView.endEditing(true)
        dataCell.removeAll()
        tableView.reloadData()
        self.activityIndicator.startAnimating()
        service.jsonURL(urlString: stringURL)
        onLoad()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    private func onLoad() {
        var model: Model?
        var cellModel: [CustomTableViewCellModel] = []
        service.getData { data, error in
            DispatchQueue.global().async{ [weak self] in
                guard let self = self else {return}
                guard let data = data else { return }
                model = self.service.parsingData(data: data)
                guard let film = model?.results else { return }
                for film in film {
                    let cell = CustomTableViewCellModel(header: film.title,
                                                        text: film.description,
                                                        date: "",
                                                        image: film.image)
                    cellModel.append(cell)
                }
                DispatchQueue.main.async {[weak self] in
                    guard let self = self else {return}
                    self.activityIndicator.stopAnimating()
                    self.dataCell = cellModel
                    self.tableView.reloadData()
                }
            }
        }
    }
}


