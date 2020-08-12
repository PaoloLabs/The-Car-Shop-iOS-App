//
//  CarListView.swift
//  The Car Shop
//
//  Created by Paolo Ramos Mendez on 8/12/20.
//  Copyright © 2020 paololabs. All rights reserved.
//

import Foundation
import UIKit

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

}

extension CarListView: CarListViewProtocol {
    func getDataFromRemoteDataManager(with carDataArray: [CarData]) {
        self.tableData = carDataArray
        self.filteredTableData = self.tableData
        self.tableView.reloadData()
    }
    
    // TODO: implement view output methods
}

extension CarListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.goCarDetailView()
    }
}

extension CarListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredTableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.filteredTableData[indexPath.row].name
        return cell
        
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
