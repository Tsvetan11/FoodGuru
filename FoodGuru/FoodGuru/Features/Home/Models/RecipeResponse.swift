//
//  Recipe.swift
//  FoodGuru
//
//  Created by Tsvetan Tsvetanov on 21.07.22.
//

import Foundation

struct RecipeResponse: Decodable {
	let id: Int
	let title: String
}

struct RecipeResultResponse: Decodable {
	let recipes: [RecipeResponse]
}
