//
//  MealDetailViewModelTests.swift
//  Fetch-Rewards-RecipeTests
//
//  Created by Keerthana Srinivasan on 6/13/24.
//

import XCTest
@testable import Fetch_Rewards_Recipe

@MainActor
final class MealDetailViewModelTests: XCTestCase {
    var viewModel: MealDetailViewModel!
    var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        viewModel = MealDetailViewModel(networkManager: mockNetworkManager!)
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        super.tearDown()
    }

    func testFetchMealDetailSuccess() async {
        await viewModel.fetchMealDetail(by: "1")
        XCTAssertNotNil(viewModel.mealDetail)
        XCTAssertEqual(viewModel.mealDetail?.strMeal, "Meal 1")
        XCTAssertEqual(viewModel.mealDetail?.ingredients.count, 2)
    }

    func testFetchMealDetailFailure() async {
        mockNetworkManager.shouldReturnError = true
        await viewModel.fetchMealDetail(by: "1")
        XCTAssertNil(viewModel.mealDetail)
    }
}
