//
//  FriendsContainer.swift
//  myVKApp
//
//  Created by Sergey Makeev on 01.03.2022.
//

import Foundation
import RealmSwift

class FriendsContainer {
	var response = [Friend]()
	
	static func map(_ dict: [String: Any]) -> FriendsContainer {
		let resp = FriendsContainer()
		if let data = dict["response"] as? [String:Any] {
			if let items = data["items"] as? [[String: Any]] {
				resp.response = items.map({
					Friend.map($0)
				})
			}
		}
		
		return resp
	}
}

class Friend: Object {
	@objc dynamic var id: Int = 0
	@objc dynamic var firstName: String = ""
	@objc dynamic var lastName: String = ""
	@objc dynamic var avatar: String = ""
	
	static func map(_ dict: [String: Any]) -> Friend {
		let friend = Friend()
		
		if let friendId = dict["id"] as? Int { friend.id = friendId }
		if let firstNameData = dict["first_name"] as? String { friend.firstName = firstNameData }
		if let lastNameData = dict["last_name"] as? String { friend.lastName = lastNameData }
		if let photo = dict["photo_200"] as? String { friend.avatar = photo }
		
		return friend
	}
}



//class Friend: Decodable {
//	let id: Int
//	var firstName: String
//	var lastName: String
//	var avatar: String
//
//	enum CodingKeys: String, CodingKey {
//		case id
//		case firstName = "first_name"
//		case lastName = "last_name"
//		case avatar = "photo_200"
//	}
//}
//
//struct FriendsContainer: Decodable {
//	let friends: [Friend]
//}
//
//extension FriendsContainer {
//	enum CodingKeys: String, CodingKey {
//		case response
//		enum ItemKeys: String, CodingKey {
//			case items
//		}
//	}
//
//	init(from decoder: Decoder) throws {
//		let mainContainer = try decoder.container(keyedBy: CodingKeys.self)
////		print("!!!!! \(mainContainer.allKeys)")
//		let itemContainer = try mainContainer.nestedContainer(keyedBy: CodingKeys.ItemKeys.self, forKey: .response)
//		friends = try itemContainer.decode([Friend].self, forKey: .items)
//	}
//}
