//
//  FoodCell.swift
//  ApiDataInTableViewFoodData
//
//  Created by Srikanth Kyatham on 12/2/24.
//

import UIKit

class FoodCell: UITableViewCell {

    @IBOutlet weak var foodGroupsDescription: UILabel!
    @IBOutlet weak var foodGroupsId: UILabel!
    @IBOutlet weak var foodGroupsName: UILabel!
    @IBOutlet weak var foodItemImage: UIImageView!
    @IBOutlet weak var foodItemsId: UILabel!
    @IBOutlet weak var foodItemsName: UILabel!
    @IBOutlet weak var foodItemsDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpItemImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUpItemImage(){
        foodItemImage.contentMode = .scaleAspectFit
        foodItemImage.layer.cornerRadius = 8
        foodItemImage.clipsToBounds = true
    }
    func config(group: Food, item: FoodItem ) {

        foodGroupsName.text = "Food Group \(group.name)"
        foodGroupsDescription.text = group.description
        foodGroupsId.text = "Food Group ID: \(group.id)"
        foodItemsName.text = "Item Name :\(item.name)"
        foodItemsDescription.text = item.description
        foodItemsId.text = "Item ID: \(item.id)"
        if !item.image_url.isEmpty {
                loadImage(from: item.image_url)
            }

    }
    
    //MARK: - API for Image Fetching
    
    private func loadImage(from url: String) {
            guard let imageURL = URL(string: url) else { return }
            URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
                guard let data, error == nil, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self?.foodItemImage.image = image
                }
            }.resume()
        }

}
