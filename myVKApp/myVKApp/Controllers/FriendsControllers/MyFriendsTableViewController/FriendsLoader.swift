//
//  FriendsLoader.swift
//  myVKApp
//
//  Created by Sergey Makeev on 14.12.2021.
//

class FriendsLoader {

	static func getFriendSections(data: [Friend]) -> [FriendsSection] {
		let sortedFriends = sortFriends(friends: data)
		let sectionsArray = formFriendsSection(friends: sortedFriends)
		return sectionsArray
	}
	
	static func sortFriends(friends: [Friend]) -> [Character: [Friend]] {
		var newFriends: [Character: [Friend]] = [:]
		for friend in friends {
			guard
				let firstChar = friend.lastName.first
				else {
					continue
				}
			guard
				var friendArray = newFriends[firstChar]
				else {
					let newValue = [friend]
					newFriends.updateValue(newValue, forKey: firstChar)
					continue
				}

			friendArray.append(friend)
			newFriends.updateValue(friendArray, forKey: firstChar)
		}
		return newFriends
	}
	
	static func formFriendsSection(friends: [Character: [Friend]]) -> [FriendsSection] {
		var sectionsArray: [FriendsSection] = []
		for (key, friendsArray) in friends {
			sectionsArray.append(FriendsSection(key: key, data: friendsArray))
		}
		sectionsArray.sort { $0 < $1 }

		return sectionsArray
	}
	
}
