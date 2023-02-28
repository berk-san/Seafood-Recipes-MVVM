//
//  APICaller.swift
//  Seafood Recipes MVVM
//
//  Created by Berk on 24.02.2023.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case noData
    case canNotParseData
}

class APICaller {
    static func getMeals(completion: @escaping (_ result: Result<MealModel,NetworkError>) -> Void) {
        let urlString = NetworkConstant.shared.baseUrl + NetworkConstant.shared.path
        guard let url = URL(string: urlString) else {
            print("urlError")
            completion(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            guard let data = dataResponse, error == nil else {
                print("noData")
                return completion(.failure(.noData))
            }
            guard let resultData = try? JSONDecoder().decode(MealModel.self, from: data) else {
                print("canNotParseData")
                return completion(.failure(.canNotParseData))
            }
            print("resultData")
            completion(.success(resultData))
        }
        .resume()
    }
    
    static func getRecipe(id: String, completion: @escaping (_ result: Result<DetailsModel,NetworkError>) -> Void) {
        let urlString = NetworkConstant.shared.baseUrl + NetworkConstant.shared.pathToDetail + id
        guard let url = URL(string: urlString) else {
            print("urlError")
            completion(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            guard let data = dataResponse, error == nil else {
                print("noData")
                return completion(.failure(.noData))
            }
            guard let resultData = try? JSONDecoder().decode(DetailsModel.self, from: data) else {
                print("canNotParseData")
                return completion(.failure(.canNotParseData))
            }
            print("resultData")
            completion(.success(resultData))
        }
        .resume()
    }
}

