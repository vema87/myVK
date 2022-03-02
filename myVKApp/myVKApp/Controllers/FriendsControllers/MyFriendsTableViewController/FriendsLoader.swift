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
		for s in sectionsArray {
			print(s)
		}
		return sectionsArray
	}
	
	static func sortFriends(friends: [Friend]) -> [Character: [Friend]] {
		print(">>> data fr: \(friends)")
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
		for s in newFriends {
			print(">>> newFriends: \(s)")
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

//	static func getFriendSections() -> [FriendsSection] {
//		let sortedFriends = sortFriends(friends: Friends.shared.internalFriendsList)
//		let sectionsArray = formFriendsSection(friends: sortedFriends)
//		return sectionsArray
//	}
//
//	static func sortFriends(friends: [FriendModel]) -> [Character: [FriendModel]] {
//		var newFriends: [Character: [FriendModel]] = [:]
//		for friend in friends {
//			guard
//				let firstChar = friend.friendLastName.first
//				else {
//					continue
//				}
//			guard
//				var friendArray = newFriends[firstChar]
//				else {
//					let newValue = [friend]
//					newFriends.updateValue(newValue, forKey: firstChar)
//					continue
//				}
//
//			friendArray.append(friend)
//			newFriends.updateValue(friendArray, forKey: firstChar)
//		}
//		return newFriends
//	}
//
//	static func formFriendsSection(friends: [Character: [FriendModel]]) -> [FriendsSection] {
//		var sectionsArray: [FriendsSection] = []
//		for (key, friendsArray) in friends {
//			sectionsArray.append(FriendsSection(key: key, data: friendsArray))
//		}
//		sectionsArray.sort { $0 < $1 }
//
//		return sectionsArray
//	}
}
