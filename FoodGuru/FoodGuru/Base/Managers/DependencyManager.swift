//
//  DependencyManager.swift
//  FoodGuru
//
//  Created by Tsvetan Tsvetanov on 22.07.22.
//

import Foundation

class DependencyManager {
	
	static let shared = DependencyManager()

	private init() {}

	func resolveHomeViewModel() -> HomeViewModel {
		let client = HTTPClientImpl()
		let requestFactory = RecipeRequestFactoryImpl()
		let service = RecipeServiceImpl(client: client, requestFactory: requestFactory)
		let repository = RecipeRepositoryImpl(service: service)
		let useCase = RecipeUseCaseImpl(recipeRepository: repository)

		return HomeViewModel(recipeUseCase: useCase)
	}
}

