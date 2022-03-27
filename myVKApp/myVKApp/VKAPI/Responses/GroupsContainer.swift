//
//  GroupsContainer.swift
//  myVKApp
//
//  Created by Sergey Makeev on 02.03.2022.
//

import Foundation
import RealmSwift

class GroupsContainer {
	var response = [Group]()
	
	static func map(_ dict: [String: Any]) -> GroupsContainer {
		let resp = GroupsContainer()
		if let data = dict["response"] as? [String:Any] {
			if let items = data["items"] as? [[String: Any]] {
				resp.response = items.map({
					Group.map($0)
				})
			}
		}
		
		return resp
	}
}

class Group: Object {
	@objc dynamic var id: Int = 0
	@objc dynamic var groupName: String = ""
	@objc dynamic var avatar: String = ""
	
	static func map(_ dict: [String: Any]) -> Group {
		let group = Group()
		
		if let groupId = dict["id"] as? Int { group.id = groupId }
		if let name = dict["name"] as? String { group.groupName = name }
		if let photo = dict["photo_200"] as? String { group.avatar = photo }
		
		return group
	}

}
