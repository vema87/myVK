//
//  FriendsContainer.swift
//  myVKApp
//
//  Created by Sergey Makeev on 01.03.2022.
//

import Foundation

class Friend: Decodable {
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

struct FriendsContainer: Decodable {
	let friends: [Friend]
}

extension FriendsContainer {
	enum CodingKeys: String, CodingKey {
		case response
		enum ItemKeys: String, CodingKey {
			case items
		}
	}
	
	init(from decoder: Decoder) throws {
		let mainContainer = try decoder.container(keyedBy: CodingKeys.self)
//		print("!!!!! \(mainContainer.allKeys)")
		let itemContainer = try mainContainer.nestedContainer(keyedBy: CodingKeys.ItemKeys.self, forKey: .response)
		friends = try itemContainer.decode([Friend].self, forKey: .items)
	}
}
