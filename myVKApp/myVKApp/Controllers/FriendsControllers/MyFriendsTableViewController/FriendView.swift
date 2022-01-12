//
//  FriendView.swift
//  myVKApp
//
//  Created by Sergey Makeev on 14.12.2021.
//

import UIKit

class FriendView: UIView {

	var image: UIImage = UIImage() {
		didSet {
			imageView.image = image
		}
	}
	
	private var imageView: UIImageView = UIImageView()
	private var containerView: UIView = UIView()
	
	@IBInspectable var shadowColor: UIColor = .black {
		didSet {
			self.updateColor()
		}
	}
	
	@IBInspectable var shadowOpacity: Float = 3.0 {
		didSet {
			self.updateOpacity()
		}
	}
	
	@IBInspectable var shadowRadius: CGFloat = 4.0 {
		didSet {
			self.updateRadius()
		}
	}
	
	@IBInspectable var shadowOffset: CGSize = .zero {
		didSet {
			self.updateOffset()
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setupImage()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		self.setupImage()
	}

	private func setupImage() {
		containerView.frame = self.bounds
		containerView.layer.cornerRadius = 20
		
		imageView.layer.masksToBounds = true
		imageView.frame = containerView.bounds
		imageView.contentMode = .scaleAspectFill
		imageView.layer.cornerRadius = imageView.frame.size.width / 2
		imageView.image = image
		
		containerView.addSubview(imageView)
		self.addSubview(containerView)
		updateShadows()
	}

	private func updateOpacity() {
		self.containerView.layer.shadowOpacity = shadowOpacity
	}
	
	private func updateColor() {
		self.containerView.layer.shadowColor = shadowColor.cgColor
	}
	
	private func updateOffset() {
		self.containerView.layer.shadowOffset = shadowOffset
	}
	private func updateRadius() {
		self.containerView.layer.shadowRadius = shadowRadius
	}
	
	private func updateShadows() {
		self.containerView.layer.shadowRadius = shadowRadius
		self.containerView.layer.shadowOpacity = shadowOpacity
		self.containerView.layer.shadowColor = shadowColor.cgColor
		self.containerView.layer.shadowOffset = shadowOffset
	}
}
