//
//  RecipeUseCase.swift
//  FoodGuru
//
//  Created by Tsvetan Tsvetanov on 22.07.22.
//

import Foundation

protocol RecipeUseCase {
	func getRandomRecipes() async throws -> [RecipeDTO]
	func getRecipeInformation(recipeId: Int) async throws -> RecipeDTO
}

class RecipeUseCaseImpl: RecipeUseCase {

	private let recipeRepository: RecipeRepository

	init(recipeRepository: RecipeRepository) {
		self.recipeRepository = recipeRepository
	}

	func getRandomRecipes() async throws -> [RecipeDTO] {
		try await recipeRepository.getRandom()
	}

	func getRecipeInformation(recipeId: Int) async throws -> RecipeDTO {
		try await recipeRepository.getInformation(id: recipeId)
	}
}
