//
//  NetworkConstant.swift
//  Seafood Recipes MVVM
//
//  Created by Berk on 23.02.2023.
//

import Foundation

class NetworkConstant {
    static var shared: NetworkConstant = NetworkConstant()
    
    private init() {
        // Singleton
    }
    
    var apiKey: String {
        get {
            return ""
        }
    }
    
    var baseUrl: String {
        get {
            return "https://www.themealdb.com/api/json/v1/1"
        }
    }
    
    var path: String {
        get {
            return "/filter.php?c=seafood"
        }
    }
    
    var pathToDetail: String {
        get {
            return "/lookup.php?i="
        }
    }
}
