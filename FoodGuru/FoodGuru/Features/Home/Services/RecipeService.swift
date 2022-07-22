//
//  TestEnpoint.swift
//  FoodGuru
//
//  Created by Tsvetan Tsvetanov on 20.07.22.
//

import Foundation

protocol RecipeService {
	func getRandom() async throws -> RecipeResultResponse
	func getInformation(id: Int) async throws -> RecipeResponse
}

struct RecipeServiceImpl: RecipeService {

	private let requestFactory: RecipeRequestFactory
	private let client: HTTPClient

	init(client: HTTPClient, requestFactory: RecipeRequestFactory) {
		self.client = client
		self.requestFactory = requestFactory
	}

	func getRandom() async throws -> RecipeResultResponse {
		try await client.sendRequest(request: requestFactory.getRandom(),
									 responseModel: RecipeResultResponse.self)
	}

	func getInformation(id: Int) async throws -> RecipeResponse {
		try await client.sendRequest(request: requestFactory.getInformation(id: id),
									 responseModel: RecipeResponse.self)
	}
}
