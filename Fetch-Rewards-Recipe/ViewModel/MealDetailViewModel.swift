//
//  MealDetailViewModel.swift
//  Fetch-Rewards-Recipe
//
//  Created by Keerthana Srinivasan on 6/12/24.
//

import SwiftUI

@MainActor
class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetail?

    private let networkManager: NetworkManaging

    init(networkManager: NetworkManaging = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    func fetchMealDetail(by id: String) async {
        do {
            self.mealDetail = try await networkManager.fetchMealDetail(by: id)
        } catch {
            print("Failed to fetch meal details: \(error)")
        }
    }
}
