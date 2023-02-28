//
//  RecipeViewModel.swift
//  Seafood Recipes MVVM
//
//  Created by Berk on 23.02.2023.
//

import Foundation

final class RecipeViewModel {
    
    var recipeID: String?
    
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
                
                var instructionsText = "Instructions:\n" + (data.meals[0].strInstructions ?? "")
                self?.recipeDetail.value = instructionsText
                
                let ingredientsArray = [
                    data.meals[0].strIngredient1,
                    data.meals[0].strIngredient2,
                    data.meals[0].strIngredient3,
                    data.meals[0].strIngredient4,
                    data.meals[0].strIngredient5,
                    data.meals[0].strIngredient6,
                    data.meals[0].strIngredient7,
                    data.meals[0].strIngredient8,
                    data.meals[0].strIngredient9,
                    data.meals[0].strIngredient10,
                    data.meals[0].strIngredient11,
                    data.meals[0].strIngredient12,
                    data.meals[0].strIngredient13,
                    data.meals[0].strIngredient14,
                    data.meals[0].strIngredient15,
                    data.meals[0].strIngredient16,
                    data.meals[0].strIngredient17,
                    data.meals[0].strIngredient18,
                    data.meals[0].strIngredient19,
                    data.meals[0].strIngredient20
                ]
                var ingredientsText = "Ingredients:\n"
                for inggredient in ingredientsArray {
                    if inggredient == ingredientsArray.first {
                        ingredientsText.append(inggredient!)
                    }
                    else if inggredient != nil && inggredient != "" {
                        ingredientsText.append(", " + inggredient!)
                    }
                }
                self?.recipeIngredients.value = ingredientsText
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
