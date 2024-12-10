//
//  FoodGroupViewModel.swift
//  ApiDataInTableViewFoodData
//
//  Created by Srikanth Kyatham on 12/9/24.
//

import Foundation

protocol FoodGroupViewModelProtocol {
    func getDataFromServer(urlString : String, completion: @escaping () -> Void)
}

class FoodGroupViewModel: FoodGroupViewModelProtocol {
    var arrFoodData: [Food] = []
    var networkManager: NetworkProtocol?
    init(networkManager: NetworkProtocol?){
        self.networkManager = networkManager
    }
    
    func getDataFromServer(urlString : String, completion: @escaping () -> Void){
        networkManager?.getData(from: urlString ) { [weak self] foodData in
            DispatchQueue.main.async {
                self?.arrFoodData = foodData?.food_groups ?? []
                completion()
            }
        }
    }
    
    //MARK: - Helper Methods
    func totalFoodItems() -> Int {
        arrFoodData.reduce(0) { $0 + $1.food_items.count }
    }
    
    func getFoodItem(at row: Int) -> (Food?,FoodItem?) {
        var foodGroup1: Food?
        var foodItem: FoodItem?
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
