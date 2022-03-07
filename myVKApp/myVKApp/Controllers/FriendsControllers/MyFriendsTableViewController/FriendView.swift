//
//  FriendView.swift
//  myVKApp
//
//  Created by Sergey Makeev on 14.12.2021.
//

import UIKit

class FriendView: UIView {

	var image: UIImage? = UIImage() {
		didSet {
			guard let imgView = imageView else { return }
			imgView.image = image
		}
	}
	
	var imageView: UIImageView? = UIImageView()
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
		
		guard let imgView = imageView else { return }
		
		imgView.layer.masksToBounds = true
		imgView.frame = containerView.bounds
		imgView.contentMode = .scaleAspectFill
		imgView.layer.cornerRadius = imgView.frame.size.width / 2
		imgView.image = image
		
		containerView.addSubview(imgView)
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
