//
//  mealListView.swift
//  Fetch-Rewards-Recipe
//
//  Created by Keerthana Srinivasan on 6/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MealViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.meals) { meal in
                    NavigationLink(destination: MealDetailView(mealID: meal.idMeal)) {
                        ZStack(alignment: .bottomLeading) {
                            if let url = URL(string: meal.strMealThumb ?? "") {
                                AsyncImage(url: url) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(height: 125)
                                        .clipped()
                                } placeholder: {
                                    ProgressView()
                                        .frame(height: 125)
                                }
                            }
                            HStack {
                                Text(meal.strMeal)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(Color.white.opacity(0.7))
                                    .cornerRadius(8)
                                    .padding([.leading, .bottom], 10)
                                Spacer()
                            }
                        }
                        .contentShape(Rectangle())
                        .listRowInsets(EdgeInsets())
                    }
                    .padding(.vertical, 5)
                }
            }
            .navigationTitle("Desserts")
            .task {
                await viewModel.fetchMeals()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
