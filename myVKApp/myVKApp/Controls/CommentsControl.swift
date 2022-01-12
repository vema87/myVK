//
//  CommentsControl.swift
//  myVKApp
//
//  Created by Sergey Makeev on 17.12.2021.
//

import UIKit

class CommentsControl: UIControl {
	var commentsCount: Int = 0

	private var stackView: UIStackView = UIStackView()
	private var commentsImage: UIImageView = UIImageView()
	private var commentsLable: UILabel = UILabel()
	private var bgView: UIView = UIView()

	private func setupView() {
		self.backgroundColor = .clear

		// imageView
		commentsImage.frame = CGRect(x: 5, y: 1, width: 22, height: 18)
		commentsImage.image = UIImage(systemName: "bubble.left")
		commentsImage.tintColor = .gray

		// label
		commentsLable.frame = CGRect(x: self.frame.size.width - 20, y: 4, width: 10, height: 12)
		commentsLable.text = String(commentsCount)
		commentsLable.textAlignment = .center
		commentsLable.textColor = .gray
		commentsLable.font = UIFont.systemFont(ofSize: 16)

		// view for likes
		bgView.frame = bounds
		bgView.addSubview(commentsImage)
		commentsLable.text = String(commentsCount)
		bgView.addSubview(commentsLable)
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

