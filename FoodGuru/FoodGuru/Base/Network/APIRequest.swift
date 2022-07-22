//
//  Endpoint.swift
//  FoodGuru
//
//  Created by Tsvetan Tsvetanov on 20.07.22.
//

import Foundation

class APIRequest {
	let scheme: String
	let host: String
	let path: String
	let method: HTTPMethod
	let params: [String: String]?
	let header: [String: String]?
	let body: [String: String]?

	init(scheme: String = APIConfiguration.shared.apiBaseScheme,
		 host: String = APIConfiguration.shared.apiBaseURL,
		 path: String,
		 method: HTTPMethod,
		 params: [String: String]? = nil,
		 header: [String: String]? = nil,
		 body: [String: String]? = nil) {
		self.scheme = scheme
		self.host = host
		self.path = path
		self.method = method
		self.params = params
		self.header = header
		self.body = body
	}
}

// MARK: - Convert to StatefulRequest

extension APIRequest {
	func stateful() -> StatefulRequest {
		StatefulRequest(scheme: self.scheme,
						host: self.host,
						path: self.path,
						method: self.method,
						params: self.params,
						header: self.header,
						body: self.body)
	}
}

// MARK: - Add Body

extension APIRequest {
	func body(_ body: [String: String]) -> APIRequest {

		var requestBody = [String: String]()

		if let currentBody = self.body {
			requestBody = currentBody
		}

		body.keys.forEach { requestBody[$0] = body[$0] }

		return APIRequest(scheme: self.scheme,
						  host: self.host,
						  path: self.path,
						  method: self.method,
						  params: self.params,
						  header: self.header,
						  body: requestBody)
	}
}

// MARK: - Add Params

extension APIRequest {

	/// Add single parameter
	func param(key: String, value: String) -> APIRequest {

		var requestParams = [String: String]()

		if let currentParams = self.params {
			requestParams = currentParams
		}

		requestParams[key] = value

		return APIRequest(scheme: self.scheme,
						  host: self.host,
						  path: self.path,
						  method: self.method,
						  params: requestParams,
						  header: self.header,
						  body: self.body)
	}

	/// Add multiple parameters
	func params(_ params: [String: String]) -> APIRequest {

		var requestParams = [String: String]()

		if let currentParams = self.params {
			requestParams = currentParams
		}

		params.keys.forEach { requestParams[$0] = params[$0] }

		return APIRequest(scheme: self.scheme,
						  host: self.host,
						  path: self.path,
						  method: self.method,
						  params: requestParams,
						  header: self.header,
						  body: self.body)
	}
}

// MARK: - Add api key in headers

extension APIRequest {
	func apiKey() -> APIRequest {
		let key = APIConfiguration.shared.apiAuthKey
		let value = APIConfiguration.shared.apiAuthValue

		var headers = [String: String]()

		if let requestHeaders = self.header {
			headers = requestHeaders
		}

		headers[key] = value

		return APIRequest(scheme: self.scheme,
						  host: self.host,
						  path: self.path,
						  method: self.method,
						  params: self.params,
						  header: headers,
						  body: self.body)
	}
}

// MARK: - StatefulRequest

final class StatefulRequest: APIRequest {
	enum State {
		case pending
		case ongoing
		case completed
	}

	var state = State.pending
}
