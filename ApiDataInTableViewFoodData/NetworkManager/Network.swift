//
//  FoodNetwork.swift
//  ApiDataInTableViewFoodData
//
//  Created by Srikanth Kyatham on 12/2/24.
//
import UIKit
import Foundation

protocol NetworkProtocol {
    func getData(from url: String,  closure: @escaping (FoodData?) -> Void)
}

class Network: @unchecked Sendable, NetworkProtocol {
    static let sharedInstance = Network()
    private init() { }
    
    func getData(from url: String,  closure: @escaping (FoodData?) -> Void) {
        guard let serverURL =  URL(string: url) else {
            print("getData: Invalid URL")
            return
        }
        
        // fetch data from server by passing URL object
        URLSession.shared.dataTask(with: URLRequest(url: serverURL), completionHandler: { data, response, error in
            
            guard let data, error == nil else {
                print("getData: Error: \(error!.localizedDescription)")
                closure(nil)
                return
            }
            
            /// DECODING THE DATA INTO STRUCTURE
            do {
                let receivedFoodData = try JSONDecoder().decode(FoodData.self, from: data)
                
                closure(receivedFoodData)
            } catch {
                print("Unable to decode json data to the Food structure \(error)")
                closure(nil)
            }
        })
        .resume()
    }
}
