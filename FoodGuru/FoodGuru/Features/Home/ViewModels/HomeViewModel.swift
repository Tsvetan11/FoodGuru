//
//  HomeViewModel.swift
//  FoodGuru
//
//  Created by Tsvetan Tsvetanov on 21.07.22.
//

import Foundation

final class HomeViewModel: ObservableObject {

	@Published private(set) var recipes = [RecipeDTO]()

	private let recipeUseCase: RecipeUseCase

	init(recipeUseCase: RecipeUseCase) {
		self.recipeUseCase = recipeUseCase
	}

	func fetchRecipes() async {
		do {
			let recipes = try await recipeUseCase.getRandomRecipes()

			await MainActor.run { [weak self] in
				self?.recipes = recipes
			}
		} catch {

			guard let error = error as? APIError else {
				print("± \(error.localizedDescription)")
				return
			}

			print("± \(error.customMessage)")
		}
	}
}
