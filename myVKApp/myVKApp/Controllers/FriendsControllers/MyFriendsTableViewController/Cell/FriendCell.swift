//
//  FriendCell.swift
//  myVKApp
//
//  Created by Sergey Makeev on 06.12.2021.
//

import UIKit

class FriendCell: UITableViewCell {

	@IBOutlet weak var friendAvatar: FriendView!
	@IBOutlet weak var friendName: UILabel!
	var friendID: Int?
	
	override func layoutSubviews() {
		super.layoutSubviews()
	}

	override func awakeFromNib() {
		//super.awakeFromNib()
		let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnAvatar(sender:)))
		//tapRecognizer.delegate = self
		self.friendAvatar.addGestureRecognizer(tapRecognizer)
	}
	
	@objc func tapOnAvatar(sender: UITapGestureRecognizer? = nil) {
		animateAvatar()
	}
	
	func animateAvatar() {
	
		let animation = CASpringAnimation(keyPath: "transform.scale")
		animation.fromValue = 0.8
		animation.toValue = 1
		animation.stiffness = 100
		animation.mass = 2
		animation.duration = 2
		animation.beginTime = CACurrentMediaTime()
		animation.fillMode = CAMediaTimingFillMode.backwards
		
		self.friendAvatar.layer.add(animation, forKey: nil)
	}
	
	func content(model: Friend) {
		friendName.text = model.lastName + " " + model.firstName
	}
	
	override func prepareForReuse() {
		friendAvatar.image = nil
	}
}
