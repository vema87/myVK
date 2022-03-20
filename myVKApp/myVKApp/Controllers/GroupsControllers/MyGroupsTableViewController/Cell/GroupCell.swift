//
//  MyGroupsCell.swift
//  myVKApp
//
//  Created by Sergey Makeev on 05.12.2021.
//

import UIKit

class GroupCell: UITableViewCell {

	@IBOutlet weak var groupName: UILabel!
	@IBOutlet weak var groupAvatar: UIImageView!
	
	override func layoutSubviews() {
		super.layoutSubviews()
	}
	
	override func prepareForReuse() {
		groupName.text = nil
		groupAvatar.image = nil
	}
}
