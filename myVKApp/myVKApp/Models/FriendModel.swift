//
//  FriendModel.swift
//  myVKApp
//
//  Created by Sergey Makeev on 06.12.2021.
//

import UIKit

struct FriendModel {
	let friendLastName: String
	let friendFirstName: String
	let friendAvatar: UIImage?
}

// Singleton friends
class Friends {
    static let shared: Friends = Friends()
    
	var internalFriendsList: [FriendModel] = [
		FriendModel(friendLastName: "Ivanov", friendFirstName: "Ivan", friendAvatar: UIImage(named: "friend1")),
		FriendModel(friendLastName: "Sidorov", friendFirstName: "Petr", friendAvatar: UIImage(named: "friend2")),
		FriendModel(friendLastName: "Surkova", friendFirstName: "Olga", friendAvatar: UIImage(named: "friend3")),
		FriendModel(friendLastName: "Petrova", friendFirstName: "Elena", friendAvatar: UIImage(named: "friend4"))
	]

    private init() {}

}
