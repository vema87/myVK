//
//  ViewsControl.swift
//  myVKApp
//
//  Created by Sergey Makeev on 17.12.2021.
//

import UIKit

class ViewsControl: UIControl {
	var viewsCount: Int = 0

	private var stackView: UIStackView = UIStackView()
	private var viewsImage: UIImageView = UIImageView()
	private var viewsLable: UILabel = UILabel()
	private var bgView: UIView = UIView()

	private func setupView() {
		self.backgroundColor = .clear

		// imageView
		viewsImage.frame = CGRect(x: 5, y: 1, width: 22, height: 18)
		viewsImage.image = UIImage(systemName: "heart.circle.fill")
		viewsImage.tintColor = .red

		// label
		viewsLable.frame = CGRect(x: self.frame.size.width - 20, y: 4, width: 10, height: 12)
		viewsLable.text = String(viewsCount)
		viewsLable.textAlignment = .center
		viewsLable.textColor = .gray
		viewsLable.font = UIFont.systemFont(ofSize: 16)

		// view for likes
		bgView.frame = bounds
		bgView.addSubview(viewsImage)
		bgView.addSubview(viewsLable)
		self.addSubview(bgView)
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setupView()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.setupView()
	}
}
