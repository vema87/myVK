//
//  FriendResponse.swift
//  myVKApp
//
//  Created by Sergey Makeev on 01.03.2022.
//

import Foundation

struct Friend: Codable {
	let id: Int
	var firstName: String
	var lastName: String
	var avatar: String
	
	enum CodingKeys: String, CodingKey {
		case id
		case firstName = "first_name"
		case lastName = "last_name"
		case avatar = "photo_200"
	}
}
