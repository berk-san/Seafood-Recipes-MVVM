//
//  MealListViewModel.swift
//  Seafood Recipes MVVM
//
//  Created by Berk on 23.02.2023.
//

import Foundation

final class MealListViewModel {
    
    var mealArray: [Meal]?
    
    func setNumberOfRows(in section: Int) -> Int {
        return mealArray?.count ?? 0
    }
    
    func fetchData() {
        
    }
    
}
