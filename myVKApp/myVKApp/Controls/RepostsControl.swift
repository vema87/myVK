//
//  RepostsControl.swift
//  myVKApp
//
//  Created by Sergey Makeev on 17.12.2021.
//

import UIKit

class RepostsControl: UIControl {
	var repostsCount: Int = 0
	lazy var tapGestureRecognizer: UITapGestureRecognizer = {
		let recognizer = UITapGestureRecognizer(target: self, action: #selector(onClick))
		recognizer.numberOfTapsRequired = 1 // tap count
		recognizer.numberOfTouchesRequired = 1 // finger count for tapping

		return recognizer
	}()

	private var stackView: UIStackView = UIStackView()
	private var repostsImageEmpty: UIImageView = UIImageView()
	private var repostsImageFill: UIImageView = UIImageView()
	private var repostsLable: UILabel = UILabel()
	private var bgView: UIView = UIView()

	private func setupView() {
		self.backgroundColor = .clear

		// imageView
		repostsImageEmpty.frame = CGRect(x: 5, y: 1, width: 22, height: 18)
		repostsImageEmpty.image = UIImage(systemName: "arrow.turn.up.right")
		repostsImageEmpty.tintColor = .gray
		
		repostsImageFill.frame = CGRect(x: 5, y: 1, width: 22, height: 18)
		repostsImageFill.image = UIImage(systemName: "arrow.turn.up.right")
		repostsImageFill.tintColor = .red

		// label
		repostsLable.frame = CGRect(x: self.frame.size.width - 20, y: 4, width: 10, height: 12)
		repostsLable.text = String(repostsCount)
		repostsLable.textAlignment = .center
		repostsLable.textColor = .gray
		repostsLable.font = UIFont.systemFont(ofSize: 16)

		// view for likes
		bgView.frame = bounds
		bgView.addSubview(repostsImageEmpty)
		bgView.addSubview(repostsLable)
		self.addSubview(bgView)
	}

	// change likes
	@objc func onClick() {
		if repostsCount == 0 {
			self.repostsLable.text = "1"
			repostsCount = 1
			UIView.transition(from: repostsImageEmpty,
							  to: repostsImageFill,
							  duration: 0.2,
							  options: .transitionCrossDissolve)
			repostsLable.textColor = .red
		} else {
			self.repostsLable.text = "0"
			repostsCount = 0
			UIView.transition(from: repostsImageFill,
							  to: repostsImageEmpty,
							  duration: 0.2,
							  options: .transitionCrossDissolve)
			repostsLable.textColor = .gray
		}

		repostsLable.text = String(repostsCount)
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
