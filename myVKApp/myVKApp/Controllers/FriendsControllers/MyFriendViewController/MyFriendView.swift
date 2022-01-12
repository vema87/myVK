//
//  MyFriendView.swift
//  myVKApp
//
//  Created by Sergey Makeev on 09.12.2021.
//

import UIKit

// @IBDesignable - draw right now in storyboard
@IBDesignable class MyFriendView: UIView {

//	@IBInspectable var shadowColor: CGColor = UIColor.gray.cgColor  {
//		didSet {
//			configureShadowColor()
//		}
//	}
	
	@IBInspectable var shadowColor: UIColor = .gray {
		didSet {
			configureShadowColor()
		}
	}
	
	@IBInspectable var shadowRadius: CGFloat = 20  {
		didSet {
			configureShadowRadius()
		}
	}
	
	@IBInspectable var shadowOpacity: Float = 0.8  {
		didSet {
			configureShadowOpacity()
		}
	}
	
	var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()

	class override var layerClass: AnyClass {
		return CAShapeLayer.self
	}
	
	// maket storyboard was downloaded
	override func awakeFromNib() {
		super.awakeFromNib()
		addSubview(imageView)
		self.layer.borderWidth = 2
		self.layer.borderColor = UIColor.black.cgColor
		imageView.layer.masksToBounds = true // чтобы не выоезли границы
		self.layer.shadowColor = shadowColor.cgColor
		self.layer.shadowOffset =  CGSize(width: 10, height: 10)
		self.layer.shadowRadius = shadowRadius
		self.layer.shadowOpacity = shadowOpacity
	}

	// sizes of subviews were counted
	override func layoutSubviews() {
		super.layoutSubviews()
		// internal bounds for our subview
		imageView.frame = bounds
		let radius = frame.size.width / 2
		self.layer.cornerRadius = radius
		imageView.layer.cornerRadius = radius
	}
	
	func setImage(_ image: UIImage?) {
		imageView.image = image
	}
	
	func configureShadowColor() {
		self.layer.shadowColor = shadowColor.cgColor
	}
	
	func configureShadowRadius() {
		self.layer.shadowRadius = shadowRadius
	}
	
	func configureShadowOpacity() {
		self.layer.shadowOpacity = shadowOpacity
	}
	
//	@IBInspectable var radius: CGFloat = 10 {
//		didSet {
//			setNeedsDisplay()
//		}
//	}
//	// draw
//	// setNeedsDisplay for redraw
//	override func draw(_ rect: CGRect) {
//		super.draw(rect)
//		guard
//			let context = UIGraphicsGetCurrentContext()
//		else {
//			return
//		}
//
//		context.setFillColor(UIColor.orange.cgColor)
//		context.fillEllipse(in: CGRect(x: rect.midX - radius,
//									   y: rect.midY - radius,
//									   width: radius * 2,
//									   height: radius * 2))
//
//	}
}
