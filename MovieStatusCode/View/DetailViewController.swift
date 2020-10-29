//
//  DetailViewController.swift
//  MovieStatusCode
//
//  Created by Kingsley Enoka on 10/28/20.
//

import UIKit

class DetailViewController: UIViewController {
  
  var titleLabel = UILabel()
  var descriptionLabel = UILabel()
  var imgView = UIImageView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    view.backgroundColor = .white
    setConstraint()
    getImage()
  }
  
  func setConstraint() {
    view.addSubview(imgView)
    view.addSubview(titleLabel)
    view.addSubview(descriptionLabel)
    
    titleLabel.text = DetailViewModel.shared.getResult()?.title
    descriptionLabel.text = DetailViewModel.shared.getResult()?.synopsis
    descriptionLabel.numberOfLines = 0
    
    imgView.translatesAutoresizingMaskIntoConstraints = false
    imgView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    imgView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    imgView.topAnchor.constraint(equalTo: view.topAnchor, constant: 88).isActive = true
    imgView.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
    descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
  }
  
  func getImage() {
    DetailViewModel.shared.getImage { data in
      guard let data = data else { return }
      let image = UIImage(data: data)
      DispatchQueue.main.async {
        self.imgView.image = image
      }
    }
  }
  
}
