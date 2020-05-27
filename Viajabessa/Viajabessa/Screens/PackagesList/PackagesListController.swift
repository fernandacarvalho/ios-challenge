//
//  PackagesListController.swift
//  Viajabessa
//
//  Created by Fernanda Carvalho on 25/03/20.
//  Copyright © 2020 Fernanda Carvalho. All rights reserved.
//

import UIKit

private enum CellReuseIdentifier: String {
    case travelPackage = "TravelPackageCell"
}

class PackagesListController: UIViewController, UITableViewDelegate, UITableViewDataSource, ListItemDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private var packages = [TravelPackage]()
    private var errorView = ErrorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureErrorView()
        self.configureTableView()
        self.loadPackageBanners()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //MARK: - SETTINGS
    
    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 400
        self.tableView.register(UINib(nibName: "TravelPackageTableViewCell", bundle: nil), forCellReuseIdentifier: CellReuseIdentifier.travelPackage.rawValue)
    }
    
    func configureErrorView() {
        self.errorView.isHidden = true
        self.errorView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        self.errorView.addTarget(self, action: #selector(self.loadPackageBanners), for: .touchUpInside)
        self.view.addSubview(self.errorView)
    }
    
    func hideErrorView() {
        self.errorView.isHidden = true
    }
    
    func showErrorView() {
        self.errorView.isHidden = false
    }
    
    //MARK: - LOAD DATA
    @objc func loadPackageBanners() {
        self.hideErrorView()
        UtilFunctions.showActivityIndicatorView(onView: self.navigationController?.view ?? self.view)
        ApplicationData.sharedInstance.getTravelPackages(completion: { (response) in
            guard let packages = response else {
                self.showErrorView()
                return
            }
            self.packages = packages
            self.tableView.reloadData()
            UtilFunctions.removeActivityIndicatorView()
        }) { () in
            self.showErrorView()
            UtilFunctions.removeActivityIndicatorView()
            return
        }
    }
    
    //MARK: - ACTIONS
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let packageId = sender as? Int64 else {
            return
        }
        if let package = self.packages.filter({ $0.id == packageId }).first {
            let detailController = segue.destination as! PackageDetailController
            detailController.travelPackage = package
        }
    }
    
    //MARK: - TABLEVIEW DELEGATE AND DATASOURCE
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.packages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.travelPackage.rawValue, for: indexPath) as! TravelPackageTableViewCell
        cell.selectionStyle = .none
        
        let package = self.packages[indexPath.row]
        cell.delegate = self
        cell.configureCellWith(package: package)
        
        return cell
    }
    
    //MARK: LIST ITEM GESTURE DELEGATE
    func didTapItem(with id: Int64) {
        self.performSegue(withIdentifier: "PushPackageDetail", sender: id)
    }
}
