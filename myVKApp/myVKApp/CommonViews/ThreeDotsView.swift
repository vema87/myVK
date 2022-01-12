//
//  LoadingView.swift
//  myVKApp
//
//  Created by Sergey Makeev on 19.12.2021.
//

import UIKit

protocol LoadingViewProtocol: AnyObject {
	var loadingView: UIView? { get set}

	func startLoadingAnimation()
	func stopLoadingAnimation()

}

extension LoadingViewProtocol where Self: UIViewController {
	func startLoadingAnimation() {
		self.loadingView = UIView()
		guard let loadingView = self.loadingView else {
			return
		}
		let backgroundView: UIView = UIView(frame: .zero)
		let threeDotsView: UIView = ThreeDotsView(frame: .zero)
		
		backgroundView.backgroundColor = .gray
		backgroundView.alpha = 0.5
		
		loadingView.backgroundColor = .clear
		
		loadingView.addSubview(backgroundView)
		loadingView.addSubview(threeDotsView)
		self.view.addSubview(loadingView)
		loadingView.bringSubviewToFront(threeDotsView)
		
		loadingView.translatesAutoresizingMaskIntoConstraints = false
		backgroundView.translatesAutoresizingMaskIntoConstraints = false
		threeDotsView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			loadingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			loadingView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
			loadingView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
			loadingView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
			
			backgroundView.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
			backgroundView.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
			backgroundView.widthAnchor.constraint(equalTo: loadingView.widthAnchor),
			backgroundView.heightAnchor.constraint(equalTo: loadingView.heightAnchor),
			
			threeDotsView.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
			threeDotsView.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
			threeDotsView.widthAnchor.constraint(equalToConstant: 200),
			threeDotsView.heightAnchor.constraint(equalToConstant: 100)
		])
	}
	
	// remove loading view
	func stopLoadingAnimation() {
		loadingView?.removeFromSuperview()
		loadingView = nil
	}
}

class ThreeDotsView: UIView {

	private let circleView1: CircleView = CircleView(frame: .zero)
	private let circleView2: CircleView = CircleView(frame: .zero)
	private let circleView3: CircleView = CircleView(frame: .zero)
	
	private var inAnimation: Bool = false
	private let width: CGFloat = 15
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .clear
		
		// additional vuews for circleViews
		let leftCircleWrapper: UIView = UIView()
		let centerCircleWrapper: UIView = UIView()
		let rightCircleWrapper: UIView = UIView()
		
		leftCircleWrapper.backgroundColor = .clear
		leftCircleWrapper.translatesAutoresizingMaskIntoConstraints = false
		
		centerCircleWrapper.backgroundColor = .clear
		centerCircleWrapper.translatesAutoresizingMaskIntoConstraints = false
		
		rightCircleWrapper.backgroundColor = .clear
		rightCircleWrapper.translatesAutoresizingMaskIntoConstraints = false
		
		addSubview(leftCircleWrapper)
		addSubview(centerCircleWrapper)
		addSubview(rightCircleWrapper)
		
		NSLayoutConstraint.activate([
			leftCircleWrapper.leadingAnchor.constraint(equalTo: leadingAnchor),
			leftCircleWrapper.heightAnchor.constraint(equalTo: heightAnchor),
			leftCircleWrapper.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3),
			
			centerCircleWrapper.leadingAnchor.constraint(equalTo: leftCircleWrapper.trailingAnchor),
			centerCircleWrapper.heightAnchor.constraint(equalTo: heightAnchor),
			centerCircleWrapper.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3),
			
			rightCircleWrapper.leadingAnchor.constraint(equalTo: centerCircleWrapper.trailingAnchor),
			rightCircleWrapper.heightAnchor.constraint(equalTo: heightAnchor),
			rightCircleWrapper.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3)
		])
		
		circleView1.translatesAutoresizingMaskIntoConstraints = false
		circleView2.translatesAutoresizingMaskIntoConstraints = false
		circleView3.translatesAutoresizingMaskIntoConstraints = false
		
		leftCircleWrapper.addSubview(circleView1)
		centerCircleWrapper.addSubview(circleView2)
		rightCircleWrapper.addSubview(circleView3)
			
		NSLayoutConstraint.activate([
			circleView2.centerXAnchor.constraint(equalTo: centerCircleWrapper.centerXAnchor),
			circleView2.centerYAnchor.constraint(equalTo: centerCircleWrapper.centerYAnchor),
			circleView2.widthAnchor.constraint(equalToConstant: width),
			
			circleView1.centerYAnchor.constraint(equalTo: leftCircleWrapper.centerYAnchor),
			circleView1.centerXAnchor.constraint(equalTo: leftCircleWrapper.centerXAnchor),
			circleView1.widthAnchor.constraint(equalToConstant: width),
			
			circleView3.centerYAnchor.constraint(equalTo: rightCircleWrapper.centerYAnchor),
			circleView3.centerXAnchor.constraint(equalTo: rightCircleWrapper.centerXAnchor),
			circleView3.widthAnchor.constraint(equalToConstant: width),
		])
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		fatalError("Not implemented")
	}
	
	func startAnimation() {
		self.circleView1.changeColor { [weak self] in
			guard let self = self else { return }
			self.circleView2.changeColor { [weak self] in
				guard let self = self else { return }
				self.circleView3.changeColor { [weak self] in
					guard let self = self else { return }
					self.startAnimation()
				}
			}
		}
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		if !inAnimation {
			startAnimation()
		}
	}
	
	deinit {
		print(">>> deinit")
	}
	
}

private class CircleView: UIView {
	private var onComplite: (() -> Void)?
	
	override func layoutSubviews() {
		super.layoutSubviews()
		layer.cornerRadius = bounds.width / 2
	}
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
		translatesAutoresizingMaskIntoConstraints = false
		widthAnchor.constraint(equalTo: heightAnchor).isActive = true
		backgroundColor = .gray
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		fatalError("Not implemented")
	}
	
	func changeColor(completionHendler: @escaping () -> Void) {
		onComplite = completionHendler
		UIView.animate(withDuration: 0.2,
					   delay: 0,
					   animations: { self.backgroundColor = .black},
					   completion: { _ in
						self.backgroundColor = .gray
						self.onComplite?()
						})
		
	}
}
