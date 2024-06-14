//
//  MealDetailView.swift
//  Fetch-Rewards-Recipe
//
//  Created by Keerthana Srinivasan on 6/12/24.
//

import SwiftUI

struct MealDetailView: View {
    @StateObject private var viewModel = MealDetailViewModel()
    var mealID: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let mealDetail = viewModel.mealDetail {
                    Text("Ingredients")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.top)

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(mealDetail.ingredients.keys.sorted(), id: \.self) { ingredient in
                            HStack {
                                Text(ingredient)
                                    .font(.subheadline)
                                    .padding(.vertical, 5)
                                Spacer()
                                Text(mealDetail.ingredients[ingredient] ?? "")
                                    .font(.subheadline)
                                    .padding(.vertical, 5)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.horizontal)

                    Text("Instructions")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.top)

                    Text(mealDetail.strInstructions)
                        .padding(.horizontal)
                        .padding(.bottom)
                } else {
                    ProgressView()
                        .onAppear {
                            Task {
                                await viewModel.fetchMealDetail(by: mealID)
                            }
                        }
                }
            }
            .navigationTitle(viewModel.mealDetail?.strMeal ?? "Loading...")
        }
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView(mealID: "52772")
    }
}
