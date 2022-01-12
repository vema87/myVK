//
//  LikeControl.swift
//  myVKApp
//
//  Created by Sergey Makeev on 10.12.2021.
//

import UIKit

class LikeControl: UIControl {
	var likesCount: Int = 0
	lazy var tapGestureRecognizer: UITapGestureRecognizer = {
		let recognizer = UITapGestureRecognizer(target: self, action: #selector(onClick))
		recognizer.numberOfTapsRequired = 1 // tap count
		recognizer.numberOfTouchesRequired = 1 // finger count for tapping

		return recognizer
	}()

	private var stackView: UIStackView = UIStackView()
	private var likesImageEmpty: UIImageView = UIImageView()
	private var likesImageFill: UIImageView = UIImageView()
	private var likesLable: UILabel = UILabel()
	private var bgView: UIView = UIView()

	private func setupView() {
		self.backgroundColor = .clear

		// imageView
		let imageEmpty = UIImage(systemName: "heart")
		likesImageEmpty.frame = CGRect(x: 5, y: 1, width: 22, height: 18)
		likesImageEmpty.image = imageEmpty
		likesImageEmpty.tintColor = .red

		let imageFill = UIImage(systemName: "heart.fill")
		likesImageFill.frame = CGRect(x: 5, y: 1, width: 22, height: 18)
		likesImageFill.image = imageFill
		likesImageFill.tintColor = .red

		// label
		likesLable.frame = CGRect(x: self.frame.size.width - 20, y: 4, width: 10, height: 12)
		likesLable.text = String(likesCount)
		likesLable.textAlignment = .center
		likesLable.textColor = .red
		likesLable.font = UIFont.systemFont(ofSize: 16)

		// view for likes
		bgView.frame = bounds
		bgView.addSubview(likesImageEmpty)
		bgView.addSubview(likesLable)
		self.addSubview(bgView)
	}

	// change likes
	@objc func onClick() {
		if likesCount == 0 {
			self.likesLable.text = "1"
			likesCount = 1

			UIView.transition(from: likesImageEmpty,
							  to: likesImageFill,
							  duration: 1,
							  options: .transitionCrossDissolve)
		} else {
			self.likesLable.text = "0"
			likesCount = 0

			UIView.transition(from: likesImageFill,
							  to: likesImageEmpty,
							  duration: 1,
							  options: .transitionCrossDissolve)
		}

		likesLable.text = String(likesCount)
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setupView()
		addGestureRecognizer(tapGestureRecognizer)
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.setupView()
		addGestureRecognizer(tapGestureRecognizer)
	}
}
