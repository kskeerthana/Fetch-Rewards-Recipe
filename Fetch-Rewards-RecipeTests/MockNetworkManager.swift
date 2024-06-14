//
//  MockNetworkManager.swift
//  Fetch-Rewards-RecipeTests
//
//  Created by Keerthana Srinivasan on 6/13/24.
//

import Foundation
@testable import Fetch_Rewards_Recipe

class MockNetworkManager: NetworkManaging {
    var shouldReturnError = false

    func fetchMeals() async throws -> [Meal] {
        if shouldReturnError {
            throw URLError(.badServerResponse)
        } else {
            return [
                Meal(idMeal: "1", strMeal: "Meal 1", strMealThumb: "https://example.com/meal1.jpg"),
                Meal(idMeal: "2", strMeal: "Meal 2", strMealThumb: "https://example.com/meal2.jpg")
            ]
        }
    }

    func fetchMealDetail(by id: String) async throws -> MealDetail {
        if shouldReturnError {
            throw URLError(.badServerResponse)
        } else {
            return MealDetail(
                idMeal: "1",
                strMeal: "Meal 1",
                strInstructions: "Instructions",
                ingredients: ["Ingredient 1": "1 cup", "Ingredient 2": "2 tsp"]
            )
        }
    }
}

