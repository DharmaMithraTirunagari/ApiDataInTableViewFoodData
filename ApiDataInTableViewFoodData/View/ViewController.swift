//
//  ViewController.swift
//  ApiDataInTableViewFoodData
//
//  Created by Srikanth Kyatham on 12/2/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Properties
    var foodgroupViewModel =  FoodGroupViewModel()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - View Controller's Life cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        configTableView()
        getDataFromServer()
    }
}

extension ViewController{
    
    //MARK: - Helper
    func configTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 200
    }
    
    func startAnimating(){
        activityIndicator.startAnimating()
    }
    
    func stopAnimating(){
        activityIndicator.stopAnimating()
    }
    
    func reloadTableView(){
        tableView.reloadData()
    }
    
    
}

extension ViewController {
    
    //MARK: - API Method
    func getDataFromServer(){
        startAnimating()
        foodgroupViewModel.getDataFromServer(urlString: ServerConstants.serverURL, completion: {
            DispatchQueue.main.async { [weak self] in
                self?.stopAnimating()
                self?.reloadTableView()
            }
        })
    }
}

//MARK: - Table View Methods
extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        foodgroupViewModel.totalFoodItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as! FoodCell
        
        guard let fetchedFood = foodgroupViewModel.getFoodItem(at: indexPath.row) as? (Food?,FoodItem?), let foodGroup = fetchedFood.0, let foodItem = fetchedFood.1 else { return cell}
        
        cell.config(group: foodGroup, item: foodItem)
        return cell
    }
}

