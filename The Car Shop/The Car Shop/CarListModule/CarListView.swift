//
//  CarListView.swift
//  The Car Shop
//
//  Created by Paolo Ramos Mendez on 8/12/20.
//  Copyright © 2020 paololabs. All rights reserved.
//

import Foundation
import UIKit
import PKHUD
import Kingfisher

class CarListView: UIViewController {

    // MARK: Properties
    var presenter: CarListPresenterProtocol?
    var tableData = [CarData]()
    var filteredTableData = [CarData]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        HUD.show(.progress)
        presenter?.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        guard navigationController != nil else { return }
        let image = UIImage(named: "headerlogo.png") //Your logo url here
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        self.filteredTableData = self.tableData
        self.tableView.reloadData()
    }
    
    func downloadImage(with urlString : String, imageView: UIImageView) {
        guard let url = URL.init(string: urlString) else {
            return
        }
        
        let resource = ImageResource(downloadURL: url)

        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                print("Image: \(value.image). Got from: \(value.cacheType)")
                imageView.image = value.image
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }

}

extension CarListView: CarListViewProtocol {
    func getDataFromRemoteDataManager(with carDataArray: [CarData]) {
        self.tableData = carDataArray
        self.filteredTableData = self.tableData
        self.tableView.reloadData()
        HUD.hide()
    }
}

extension CarListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.goCarDetailView(carData: self.filteredTableData[indexPath.row])
    }
}

extension CarListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredTableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let carData = self.filteredTableData[indexPath.row]
        if let foundView = view.viewWithTag(1) as? UIImageView {
            let url = (carData.media.count > 0) ? carData.media[0].stringValue : ""
            self.downloadImage(with: url, imageView: foundView)
            foundView.layer.cornerRadius = 10.0
        }
        if let name = view.viewWithTag(2) as? UILabel {
            name.text = carData.name
        }
        if let model = view.viewWithTag(3) as? UILabel {
            model.text = "Model: \(carData.model) - \(carData.year)"
        }
        if let status = view.viewWithTag(4) as? UILabel {
            status.text = "Status: \(carData.status)"
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
}

extension CarListView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.filteredTableData = self.tableData
        }
        else {
            self.filteredTableData = self.tableData.filter { (data: CarData) -> Bool in
                if data.name.lowercased().contains(searchText.lowercased()){
                  return true
               } else{
                  return false
               }
            }
        }
        self.tableView.reloadData()
        
    }
}


