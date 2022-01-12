//
//  FriendsSection.swift
//  myVKApp
//
//  Created by Sergey Makeev on 14.12.2021.
//

struct FriendsSection: Comparable {
	var key: Character
	var data: [FriendModel]
	
	static func < (lhs: FriendsSection, rhs: FriendsSection) -> Bool {
		return lhs.key < rhs.key
	}
	
	static func == (lhs: FriendsSection, rhs: FriendsSection) -> Bool {
		return lhs.key == rhs.key
	}
}
