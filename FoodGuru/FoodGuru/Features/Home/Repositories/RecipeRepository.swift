//
//  RecipeRepository.swift
//  FoodGuru
//
//  Created by Tsvetan Tsvetanov on 21.07.22.
//

import Foundation

protocol RecipeRepository {
	func getRandom() async throws -> [RecipeDTO]
	func getInformation(id: Int) async throws -> RecipeDTO
}

struct RecipeRepositoryImpl: RecipeRepository {

	private let service: RecipeService

	init(service: RecipeService) {
		self.service = service
	}

	func getRandom() async throws -> [RecipeDTO] {
		try await service.getRandom().recipes.map({ recipeResponse in
			RecipeDTO(id: recipeResponse.id,
					  title: recipeResponse.title)
		})
	}

	func getInformation(id: Int) async throws -> RecipeDTO {
		let recipeInformation = try await service.getInformation(id: id)

		return RecipeDTO(id: recipeInformation.id,
						 title: recipeInformation.title)
	}
}
