//
//  Recipe.swift
//  Seafood Recipes MVVM
//
//  Created by Berk on 22.02.2023.
//

import UIKit

class Recipe: UIViewController {
    
    private let viewModel: RecipeViewModel = RecipeViewModel()

    @IBOutlet weak var recipeDetailsLabel: UILabel!
    @IBOutlet weak var recipeIngredientsLabel: UILabel!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
