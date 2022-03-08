//
//  GroupsContainer.swift
//  myVKApp
//
//  Created by Sergey Makeev on 02.03.2022.
//

import Foundation

class Group: Decodable {
	let id: Int
	var groupName: String
	var avatar: String
	
	enum CodingKeys: String, CodingKey {
		case id
		case groupName = "name"
		case avatar = "photo_200"
	}
}

struct GroupsContainer: Decodable {
	let groups: [Group]
}

extension GroupsContainer {
	enum CodingKeys: String, CodingKey {
		case response
		enum ItemKeys: String, CodingKey {
			case items
		}
	}
	
	init(from decoder: Decoder) throws {
		let mainContainer = try decoder.container(keyedBy: CodingKeys.self)
		let itemContainer = try mainContainer.nestedContainer(keyedBy: CodingKeys.ItemKeys.self, forKey: .response)
		groups = try itemContainer.decode([Group].self, forKey: .items)
	}
}
