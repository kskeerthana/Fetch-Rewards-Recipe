//
//  MealViewModelTests.swift
//  Fetch-Rewards-RecipeTests
//
//  Created by Keerthana Srinivasan on 6/13/24.
//

import XCTest
@testable import Fetch_Rewards_Recipe

@MainActor
final class MealViewModelTests: XCTestCase {
    var viewModel: MealViewModel!
    var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        viewModel = MealViewModel(networkManager: mockNetworkManager!)
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        super.tearDown()
    }

    func testFetchMealsSuccess() async {
        await viewModel.fetchMeals()
        XCTAssertEqual(viewModel.meals.count, 2)
        XCTAssertEqual(viewModel.meals.first?.strMeal, "Meal 1")
    }

    func testFetchMealsFailure() async {
        mockNetworkManager.shouldReturnError = true
        await viewModel.fetchMeals()
        XCTAssertEqual(viewModel.meals.count, 0)
    }
}

