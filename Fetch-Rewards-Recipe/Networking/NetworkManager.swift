//
//  NetworkModel.swift
//  Fetch-Rewards-Recipe
//
//  Created by Keerthana Srinivasan on 6/12/24.
//

import Foundation

protocol NetworkManaging {
    func fetchMeals() async throws -> [Meal]
    func fetchMealDetail(by id: String) async throws -> MealDetail
}

class NetworkManager: NetworkManaging {
    static let shared = NetworkManager()

    func fetchMeals() async throws -> [Meal] {
        let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let mealResponse = try JSONDecoder().decode(MealResponse.self, from: data)
        return mealResponse.meals.sorted(by: { $0.strMeal < $1.strMeal })
    }

    func fetchMealDetail(by id: String) async throws -> MealDetail {
        let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let mealDetailResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data)
        guard let mealDetail = mealDetailResponse.meals.first else {
            throw URLError(.cannotParseResponse)
        }
        return mealDetail
    }
}
