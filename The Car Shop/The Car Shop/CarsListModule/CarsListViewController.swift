//
//  CarsListViewController.swift
//  The Car Shop
//
//  Created by Paolo Ramos Mendez on 8/11/20.
//  Copyright © 2020 paololabs. All rights reserved.
//

import UIKit

class CarsListViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        guard navigationController != nil else { return }
        let image = UIImage(named: "headerlogo.png") //Your logo url here
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        self.filteredTableData = tableData
        self.tableView.reloadData()
    }
    
    // MARK: - Properties
    var presenter: ViewToPresenterCarsListProtocol?
    let tableData = ["One","Two","Three","Twenty-One"]
    var filteredTableData = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
}

extension CarsListViewController: PresenterToViewCarsListProtocol{
    // TODO: Implement View Output Methods
}

extension CarsListViewController: UITableViewDelegate {
    
}

extension CarsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredTableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.filteredTableData[indexPath.row]
        print(tableData[indexPath.row])
        return cell
        
    }
}

extension CarsListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.filteredTableData = self.tableData
        }
        else {
            self.filteredTableData = self.tableData.filter { (data: String) -> Bool in
               if data.lowercased().contains(searchText.lowercased()){
                  return true
               } else{
                  return false
               }
            }
        }
        self.tableView.reloadData()
        
    }
    
}


