//
//  ViewController.swift
//  MovieStatusCode
//
//  Created by Kingsley Enoka on 10/28/20.
//

import UIKit

class ViewController: UIViewController {

  var tblView = UITableView()
  var searchBar = UISearchBar()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    view.backgroundColor = .white
    navigationItem.title = "Search Anime"
    setTableConstrains()
    tblView.dataSource = self
    tblView.delegate = self
    searchBar.delegate = self
    searchBar.placeholder = "Enter anime name"
  }
  
  func getAnimes(searchText: String) {
    ViewModel.shared.getAnimes(urlString: "https://api.jikan.moe/v3/search/anime?q=\(searchText)") { [weak self] result in
      switch result {
      case .success( _):
        DispatchQueue.main.async {
          self?.tblView.reloadData()
        }
      case .failure(let error):
        DispatchQueue.main.async {
          self?.displayError(code: error.code)
        }
      }
    }
  }

  func displayError(code: Int) {
    let possibleError = ResponseError(rawValue: "\(code)")
    var title = ""
    switch possibleError {
      case .badURL:
        title = "Bad URL"
      case .serverError:
        title = "Server Error"
      default:
        title = "Unkwown Error"
    }
    
    let alert = UIAlertController(title: "Status Code: \(title)", message: "Unable to Load Data!!!!", preferredStyle: .alert)
    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alert.addAction(cancel)
    present(alert, animated: true)
  }
  
  func setTableConstrains() {
    view.addSubview(searchBar)
    view.addSubview(tblView)
    
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    
    tblView.translatesAutoresizingMaskIntoConstraints = false
    tblView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
    tblView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    tblView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    tblView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
  }
  
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ViewModel.shared.numberOfAnime()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = ViewModel.shared.getAnime(at: indexPath.row).title
    return cell
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let dVC = DetailViewController()
    let result = ViewModel.shared.getAnime(at: indexPath.row)
    DetailViewModel.shared.setResult(result: result)
    navigationController?.pushViewController(dVC, animated: true)
  }
}

extension ViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if let searched = searchBar.text {
      getAnimes(searchText: searched)
    }
  }
}

enum ResponseError: String {
  case badURL = "400"
  case serverError = "500"
}
