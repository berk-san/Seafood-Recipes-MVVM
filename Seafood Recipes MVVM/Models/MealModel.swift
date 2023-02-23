//
//  MealModel.swift
//  Seafood Recipes MVVM
//
//  Created by Berk on 23.02.2023.
//

import Foundation

struct MealModel: Codable {
    let meals: [Meal]
}

struct Meal: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
