//
//  RecipeViewModel.swift
//  Seafood Recipes MVVM
//
//  Created by Berk on 23.02.2023.
//

import Foundation

final class RecipeViewModel {
    
    var recipeID: String?
//    var recipeDetail: String?
//    var recipeIngredients: String?
//    var recipeTitle: String?
//    var recipeImage: URL?
    
    var isLoading: ObservableObject<Bool> = ObservableObject(false)
    
    var recipeDetail: ObservableObject<String> = ObservableObject(nil)
    var recipeIngredients: ObservableObject<String> = ObservableObject(nil)
    var recipeTitle: ObservableObject<String> = ObservableObject(nil)
    var recipeImageUrl: ObservableObject<URL> = ObservableObject(nil)
    
    init(id: String) {
        self.recipeID = id
    }
    
    func fetchRecipe() {
        guard let id = recipeID else {
            print("ID cannot be created")
            return
        }
        
        if isLoading.value ?? true {
            return
        }
        
        self.isLoading.value = true
        
        APICaller.getRecipe(id: id) { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success(let data):
                print(data)
                // Data will be used
                self?.recipeDetail.value = data.meals[0].strInstructions
                self?.recipeIngredients.value = data.meals[0].strIngredient1
                self?.recipeTitle.value = data.meals[0].strMeal
                if let urlString = data.meals[0].strMealThumb {
                    let url = URL(string: urlString)
                    self?.recipeImageUrl.value = url
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
