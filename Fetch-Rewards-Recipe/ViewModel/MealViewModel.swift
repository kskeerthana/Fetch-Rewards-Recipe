//
//  MealView.swift
//  Fetch-Rewards-Recipe
//
//  Created by Keerthana Srinivasan on 6/12/24.
//

import SwiftUI

@MainActor
class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = []

    let networkManager: NetworkManaging

    init(networkManager: NetworkManaging = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    func fetchMeals() async {
        do {
            self.meals = try await networkManager.fetchMeals()
        } catch {
            print("Failed to fetch meals: \(error)")
        }
    }
}
