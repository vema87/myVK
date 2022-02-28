//
//  VkService.swift
//  myVKApp
//
//  Created by Sergey Makeev on 01.03.2022.
//

import Foundation

struct Request {
	var session = URLSession(configuration: URLSessionConfiguration.default)
	
	let host: Host
	var scheme: Scheme
	var path: Path
	var params: [String: String] = [:]
	
	var url: URL? {
		var components = URLComponents()
		components.scheme = scheme.rawValue
		components.host = host.rawValue
		components.path = path.rawValue
		components.queryItems = params.map({URLQueryItem(name: $0.key, value: $0.value)})
		
		return components.url
	}

}

extension Request {
	enum Scheme: String {
		case http = "http"
		case https = "https"
	}
	
	enum Host: String {
		case apiVkCom = "api.vk.com"
	}
	
	enum Path: String {
		case getFriends = "/method/friends.get"
		case getAllPhotos = "/method/photos.getAll"
		case getGroups = "/method/groups.get"
		case getGroupsById = "/method/groups.getById"
		case searchGroups = "/method/groups.search"
	}
}


class VkService {
	static let shared = VkService()
	
	private init() {}
	
	func load(request: Request) {
		guard let url = request.url else { return }
		
		request.session.dataTask(with: url) { (data, response, error) in
			if let error = error {
				print("Error ", error.localizedDescription)
			}
			
			guard let data = data else { return }
			
			let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
			print(json)
		}.resume()
	}
	
	func getFriends(_ userID: String) {
		let params = [
			"access_token": Session.shared.token,
			"user_id": userID,
			"order": "name",
			"v": "5.131",
			"fields": "id,first_name,last_name"
		]
		let request = Request(host: .apiVkCom,
						scheme: .https,
						path: .getFriends,
						params: params)
		
		load(request: request)
	}
	
	func getUserPhotos(_ userID: String) {
		let params = [
			"access_token": Session.shared.token,
			"owner_id": userID,
			"v": "5.131"
		]
		let request = Request(host: .apiVkCom,
						scheme: .https,
						path: .getAllPhotos,
						params: params)
		
		load(request: request)
	}
	
	func getUserGroupList(_ userID: String) {
		let params = [
			"access_token": Session.shared.token,
			"user_id": userID,
			"extended": "1",
			"v": "5.131"
		]
		let request = Request(host: .apiVkCom,
						scheme: .https,
						path: .getGroups,
						params: params)
		
		load(request: request)
	}
	
	func getGroupDataByID(_ groupID: String) {
		let params = [
			"access_token": Session.shared.token,
			"group_id": groupID,
			"v": "5.131"
		]
		let request = Request(host: .apiVkCom,
						scheme: .https,
						path: .getGroupsById,
						params: params)
		
		load(request: request)
	}
	
	func getGroupDataByString(_ searchString: String) {
		let params = [
			"access_token": Session.shared.token,
			"q": searchString,
			"sort": "0",
			"v": "5.131"
		]
		let request = Request(host: .apiVkCom,
						scheme: .https,
						path: .searchGroups,
						params: params)
		
		load(request: request)
	}
}
