//
//  ViewController.swift
//  ApiDataInTableViewFoodData
//
//  Created by Srikanth Kyatham on 12/2/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Properties
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var arrFoodData: [Food]? = []
    
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
    
    func totalFoodItems() -> Int {
        arrFoodData?.reduce(0) { $0 + $1.food_items.count } ?? 0
    }
    
    func getFoodItem(at row: Int) -> (Food?,FoodItem?) {
        var foodGroup1: Food?
        var foodItem: FoodItem?
        guard let arrFoodData = arrFoodData else { return (foodGroup1, foodItem) }
        var rowIndex = row
        for foodGroup in arrFoodData {
            foodGroup1 = foodGroup
            if rowIndex < foodGroup.food_items.count {
                foodItem = foodGroup.food_items[rowIndex]
                break
            }
            rowIndex -= foodGroup.food_items.count
        }
        return (foodGroup1,foodItem)
    }
}

extension ViewController {
    
    //MARK: - API Method
    func getDataFromServer(){
        startAnimating()
        Network.sharedInstance.getData(from: ServerConstants.serverURL) { [weak self] foodData in
            DispatchQueue.main.async {
                self?.stopAnimating()
                print(foodData!)
                self?.arrFoodData = foodData?.food_groups
                self?.reloadTableView()
            }
        }
    }
}

//MARK: - Table View Methods
extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        totalFoodItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as! FoodCell
        
        guard let fetchedFood = getFoodItem(at: indexPath.row) as? (Food?,FoodItem?), let foodGroup = fetchedFood.0, let foodItem = fetchedFood.1 else { return cell}
        
        cell.config(group: foodGroup, item: foodItem)
        return cell
    }
}

