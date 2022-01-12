//
//  GroupModel.swift
//  myVKApp
//
//  Created by Sergey Makeev on 06.12.2021.
//

import UIKit

struct GroupModel {
	let groupName: String
	let groupAvatar: UIImage?
}

// Singleton groups
class Groups {
    static let shared: Groups = Groups()
    
    var internalGroups: [GroupModel] = [
		GroupModel(groupName: "Group1", groupAvatar: UIImage(named: "group1")),
		GroupModel(groupName: "Group2", groupAvatar: UIImage(named: "group2"))
	]
	
    var externalGroups: [GroupModel] = [
		GroupModel(groupName: "Group3", groupAvatar: UIImage(named: "group3")),
		GroupModel(groupName: "Group4", groupAvatar: UIImage(named: "group4"))
	]
    
    private init() {}

	func find(_ what: String) -> Int? {
		
		for (index, group) in externalGroups.enumerated() {
			if group.groupName == what {
				return index
			}
		}
		return nil
	}

    func join(_ index: Int) {
        let group = externalGroups.remove(at: index)
		internalGroups.append(group)
		print("internal groups: \(internalGroups), \n external groups: \(externalGroups)")
    }

    func leave(_ index: Int) {
		let group = internalGroups.remove(at: index)
		externalGroups.append(group)
		print("internal groups: \(internalGroups), \n external groups: \(externalGroups)")
    }
}
