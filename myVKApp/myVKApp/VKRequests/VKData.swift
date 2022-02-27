//
//  VKData.swift
//  myVKApp
//
//  Created by Sergey Makeev on 13.01.2022.
//

import Foundation
import WebKit

class VKData {
	let configuration:URLSessionConfiguration
	let session: URLSession
	
	init() {
		self.configuration = URLSessionConfiguration.default
		self.session = URLSession(configuration: configuration)
	}
	
	/// Get friends list
	func getFriensList(_ userID: String) {
		var urlConstructor = URLComponents()
		
		urlConstructor.scheme = "https"
		urlConstructor.host = "api.vk.com"
		urlConstructor.path = "/method/friends.get"
		urlConstructor.queryItems = [
			URLQueryItem(name: "access_token", value: Session.shared.token),
			URLQueryItem(name: "user_id", value: userID),
			URLQueryItem(name: "order", value: "name"),
			URLQueryItem(name: "v", value: "5.131"),
			URLQueryItem(name: "fields", value: "id,first_name,last_name")
		]
		
		guard let url = urlConstructor.url as? URL else {
			return
		}
		
		let request = URLRequest(url: url)
		let task = session.dataTask(with: request) { (data, response, error) in
			let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
			print(">>> GET FRIENDS: \(json)")
		}
		task.resume()
	}
	
	/// Get all photos for user
	func getUserPhotos(_ userID: String) {
		var urlConstructor = URLComponents()
		
		urlConstructor.scheme = "https"
		urlConstructor.host = "api.vk.com"
		urlConstructor.path = "/method/photos.getAll"
		urlConstructor.queryItems = [
			URLQueryItem(name: "access_token", value: Session.shared.token),
			URLQueryItem(name: "owner_id", value: userID),
			URLQueryItem(name: "v", value: "5.131")
		]
		
		guard let url = urlConstructor.url as? URL else {
			return
		}
		
		let request = URLRequest(url: url)
		let task = session.dataTask(with: request) { (data, response, error) in
			let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
			print(">>> GET PHOTOS: \(json)")
		}
		task.resume()
	}

	/// Get all groups for user
	func getUserGroupList(_ userID: String) {
		var urlConstructor = URLComponents()
		
		urlConstructor.scheme = "https"
		urlConstructor.host = "api.vk.com"
		urlConstructor.path = "/method/groups.get"
		urlConstructor.queryItems = [
			URLQueryItem(name: "access_token", value: Session.shared.token),
			URLQueryItem(name: "user_id", value: userID),
			URLQueryItem(name: "extended", value: "1"),
			URLQueryItem(name: "v", value: "5.131")
		]
		
		guard let url = urlConstructor.url as? URL else {
			return
		}
		
		let request = URLRequest(url: url)
		let task = session.dataTask(with: request) { (data, response, error) in
			let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
			print(">>> GET GROUP LIST: \(json)")
		}
		task.resume()
	}
	
	/// Get group data
	func getGroupData(_ groupID: String) {
		var urlConstructor = URLComponents()
		
		urlConstructor.scheme = "https"
		urlConstructor.host = "api.vk.com"
		urlConstructor.path = "/method/groups.getById"
		urlConstructor.queryItems = [
			URLQueryItem(name: "access_token", value: Session.shared.token),
			URLQueryItem(name: "group_id", value: groupID),
			URLQueryItem(name: "v", value: "5.131")
		]
		
		guard let url = urlConstructor.url as? URL else {
			return
		}
		
		let request = URLRequest(url: url)
		let task = session.dataTask(with: request) { (data, response, error) in
			let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
			print(">>> GET GROUP DATA: \(json)")
		}
		task.resume()
	}
}
