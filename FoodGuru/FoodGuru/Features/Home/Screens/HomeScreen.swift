//
//  HomeScreen.swift
//  FoodGuru
//
//  Created by Tsvetan Tsvetanov on 21.07.22.
//

import SwiftUI

struct HomeScreen: View {

	@StateObject private var viewModel: HomeViewModel

	init(viewModel: HomeViewModel) {
		_viewModel = StateObject.init(wrappedValue: viewModel)
	}

	var body: some View {
		VStack {
			ForEach(viewModel.recipes) { recipe in
				Text(recipe.title)
					.font(.title)
					.foregroundColor(.blue)
					.padding()
			}
		}
		.task {
			await viewModel.fetchRecipes()
		}
	}
}
