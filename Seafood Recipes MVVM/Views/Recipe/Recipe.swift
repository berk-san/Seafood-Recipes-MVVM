//
//  Recipe.swift
//  Seafood Recipes MVVM
//
//  Created by Berk on 22.02.2023.
//

import UIKit
import SDWebImage

class Recipe: UIViewController {

    @IBOutlet weak var recipeDetailsLabel: UILabel!
    @IBOutlet weak var recipeIngredientsLabel: UILabel!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let viewModel: RecipeViewModel
    
    init(viewModel: RecipeViewModel) {
        self.viewModel = viewModel
        // nibName will be "RecipeViewModel"
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupBinders()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchRecipe()
    }
    
    func configureUI() {
        self.title = "Recipe Detail"
        self.view.backgroundColor = .systemBackground
        recipeImageView.round(20)
    }
    
    func setupBinders() {
        viewModel.isLoading.bind { [weak self] loading in
            guard let self = self, let loading = loading else { return }
            DispatchQueue.main.async {
                if loading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.recipeDetail.bind { [weak self] result in
            guard let self = self, let result = result else { return }
            DispatchQueue.main.async {
                self.recipeDetailsLabel.text = result
            }
        }
        viewModel.recipeIngredients.bind { [weak self] result in
            guard let self = self, let result = result else { return }
            DispatchQueue.main.async {
                self.recipeIngredientsLabel.text = result
            }
        }
        viewModel.recipeTitle.bind { [weak self] result in
            guard let self = self, let result = result else { return }
            DispatchQueue.main.async {
                self.recipeTitleLabel.text = result
            }
        }
        viewModel.recipeImageUrl.bind { [weak self] result in
            guard let self = self, let result = result else { return }
            DispatchQueue.main.async {
                self.recipeImageView.sd_setImage(with: result, placeholderImage: UIImage(named: "food-app.png"))
            }
        }
    }
}
