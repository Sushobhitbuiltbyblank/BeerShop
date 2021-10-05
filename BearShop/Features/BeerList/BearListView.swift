//
//  ViewController.swift
//  BeerShop
//
//  Created by Sushobhit.Jain on 04/10/21.
//

import UIKit

class BeerListView: UIViewController {

    @IBOutlet var tableView: UITableView!
    var currentPage:Int = 1
    var viewModel: BeerListViewModel = BeerListViewModel()
    var operation = OperationQueue()
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        fetchSourceData()
    }
    
    func setUpView() {
        self.tableView.register(UINib(nibName: "BeerTableViewCell", bundle: nil), forCellReuseIdentifier: "BeerTableViewCell")
        self.tableView.tableFooterView = UIView()
        self.tableView.prefetchDataSource = self
        self.activityIndicator.hidesWhenStopped = true
        self.tableView.estimatedRowHeight = 130
        self.tableView.rowHeight = UITableView.automaticDimension
        self.title = "Beer Shop"
    }
    
    func fetchSourceData() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.viewModel.fetchBeers(page: self.currentPage)
            self.viewModel.updateList = { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.tableView.reloadData()
            }
        }
    }
    
    func moveToDetail(element:BeerElement) {
        guard let next = self.storyboard?.instantiateViewController(withIdentifier: "BeerDetailsVC") as? BeerDetailsVC else {
            return
        }
        next.viewModel = BeerDetailViewModel()
        next.viewModel.beer = element
        next.title = element.name ?? ""
        self.navigationController?.pushViewController(next, animated: true)
    }


}

extension BeerListView : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.beerList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let element = viewModel.beerList?[indexPath.item] else {
            return UITableViewCell()
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BeerTableViewCell", for: indexPath) as? BeerTableViewCell {
            cell.configCell(element: element)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let element = viewModel.beerList?[indexPath.item] else { return }
        self.moveToDetail(element: element)
    }
}

extension BeerListView : UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if let index = indexPaths.first?.item, index >= ((self.viewModel.beerList?.count ?? 0) - 6) {
            currentPage += 1
            self.operation.addOperation {
                self.fetchSourceData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        if let index = indexPaths.last?.item, index <= currentPage * 25 {
            self.operation.cancelAllOperations()
        }
    }
    
    
}
