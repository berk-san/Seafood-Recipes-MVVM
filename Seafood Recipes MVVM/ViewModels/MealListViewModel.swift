//
//  MealListViewModel.swift
//  Seafood Recipes MVVM
//
//  Created by Berk on 23.02.2023.
//

import Foundation

final class MealListViewModel {
    
    var mealArray: [Meal]?
    
    var isLoading: ObservableObject<Bool> = ObservableObject(false)
    
    var cellDataArray: ObservableObject<[MealCellViewModel]> = ObservableObject(nil)
    
    func setNumberOfRows(in section: Int) -> Int {
        return mealArray?.count ?? 0
    }
    
    func fetchData() {
        if isLoading.value ?? true {
            return
        }
        self.isLoading.value = true
        APICaller.getMeals { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success(let data):
                print(data)
                self?.mealArray = data.meals
                let firstMeal = MealCellViewModel(meal: data.meals[0])
                print(firstMeal)
                self?.mapCellData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func mapCellData() {
        self.cellDataArray.value = self.mealArray?.compactMap({MealCellViewModel(meal: $0)})
    }
    
}
