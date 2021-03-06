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
	
	func loadFriends(request: Request, completion: @escaping ([Friend]) -> Void) {
		guard let url = request.url else { return }
		
		request.session.dataTask(with: url) { (data, response, error) in
			if let error = error {
				print("Error ", error.localizedDescription)
			}
			
			guard let data = data else { return }
			
			let json = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
			completion(FriendsContainer.map(json).response)
			
		}.resume()
	}
	
	func loadGroups(request: Request, completion: @escaping ([Group]) -> Void) {
		guard let url = request.url else { return }
		
		request.session.dataTask(with: url) { (data, response, error) in
			if let error = error {
				print("Error ", error.localizedDescription)
			}
			
			guard let data = data else { return }
			
			let json = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
			completion(GroupsContainer.map(json).response)

		}.resume()
	}
	
	func loadPhotos(request: Request, completion: @escaping ([Photo]) -> Void) {
		guard let url = request.url else { return }
		
		request.session.dataTask(with: url) { (data, response, error) in
			if let error = error {
				print("Error ", error.localizedDescription)
			}
			
			guard let data = data else { return }
			
			let json = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
//			print(" >>> photo: \(json)")
//			let array = PhotosContainer.map(json).response
//			for a in array {
//				print("!!! owner: \(a.ownerId)")
//			}
			completion(PhotosContainer.map(json).response)
				
		}.resume()
	}
	
	func getFriends(_ userID: Int, completion: @escaping ([Friend]) -> Void) {
		let params = [
			"access_token": Session.shared.token,
			"user_id": String(userID),
			"order": "name",
			"v": "5.131",
			"fields": "id,first_name,last_name, photo_200"
		]
		let request = Request(host: .apiVkCom,
						scheme: .https,
						path: .getFriends,
						params: params)
		
		loadFriends(request: request, completion: completion)
	}
	
	func getUserGroupsList(_ userID: Int, completion: @escaping ([Group]) -> Void) {
		let params = [
			"access_token": Session.shared.token,
			"user_id": String(userID),
			"extended": "1",
			"v": "5.131"
		]
		let request = Request(host: .apiVkCom,
						scheme: .https,
						path: .getGroups,
						params: params)
		loadGroups(request: request, completion: completion)
	}
	
	func getUserPhotos(_ userID: Int, completion: @escaping ([Photo]) -> Void) {
		let params = [
			"access_token": Session.shared.token,
			"owner_id": String(userID),
			"count": "100",
			"v": "5.131"
		]
		let request = Request(host: .apiVkCom,
						scheme: .https,
						path: .getAllPhotos,
						params: params)
		
		loadPhotos(request: request, completion: completion)
//		loadPhotos(request: request)
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
		
		//load(request: request)
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
		
		//load(request: request)
	}
}
