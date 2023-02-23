//
//  MealCellViewModel.swift
//  Seafood Recipes MVVM
//
//  Created by Berk on 23.02.2023.
//

import Foundation

class MealCellViewModel {
    var id: String
    var mealName: String
    var mealImageUrl: URL?
    
    init(meal: Meal) {
        self.id = meal.idMeal
        self.mealName = meal.strMeal
        self.mealImageUrl = URL(string: meal.strMealThumb)
    }
}
