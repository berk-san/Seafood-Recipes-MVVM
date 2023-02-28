//
//  MealCell.swift
//  Seafood Recipes MVVM
//
//  Created by Berk on 22.02.2023.
//

import UIKit
import SDWebImage

class MealCell: UITableViewCell {
    
    static var identifier: String {
        get {
            return "MealCell"
        }
    }
    
    static func register() -> UINib {
        UINib(nibName: "MealCell", bundle: nil)
    }
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    func configureUI() {
        cellView.addBorder(color: .label, width: 0.5)
        cellView.round()
        cellImageView.round(5)
        cellView.backgroundColor = .systemFill
    }
    
    func setupCell(viewModel: MealCellViewModel) {
        cellNameLabel.text = viewModel.mealName
        cellImageView.sd_setImage(with: viewModel.mealImageUrl)
    }
    
}
