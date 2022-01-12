//
//  ViewController.swift
//  myVKApp
//
//  Created by Sergey Makeev on 29.11.2021.
//

import UIKit

class LoginViewController: UIViewController, LoadingViewProtocol {

	var loadingView: UIView?
	
	@IBOutlet weak var loginInput: UITextField!
	@IBOutlet weak var passwordInput: UITextField!
	@IBOutlet weak var scrollView: UIScrollView!
	
	// MARK: - LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		self.startLoadingAnimation()
		DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
			self.stopLoadingAnimation()
		}
		
		let hideKeyBoardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
		scrollView.addGestureRecognizer(hideKeyBoardGesture)
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)),
											   name: UIResponder.keyboardWillShowNotification,
											   object: nil)
		
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)),
											   name: UIResponder.keyboardWillHideNotification,
											   object: nil)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		NotificationCenter.default.removeObserver(self,
												  name: UIResponder.keyboardWillShowNotification,
												  object: nil)
		
		NotificationCenter.default.removeObserver(self,
												  name: UIResponder.keyboardWillHideNotification,
												  object: nil)
	}
	
	override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
		let checkResult = checkUserData()
		
		if !checkResult {
			showLoginError()
		}
		
		loginInput.text = ""
		passwordInput.text = ""
		
		return checkResult
	}
	
	@objc func hideKeyboard() {
		scrollView.endEditing(true)
	}
	
	@objc func keyboardWasShown(notification: Notification) {
		let info = notification.userInfo!
		let rect: CGRect = info[UIResponder.keyboardFrameBeginUserInfoKey] as! CGRect
		let kbSize = rect.size
		let insets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
		
		scrollView.contentInset = insets
		scrollView.scrollIndicatorInsets = insets
		
		var aRect = self.view.frame;
		aRect.size.height -= kbSize.height;
		
		let activeField: UITextField? = [loginInput, passwordInput].first { $0.isFirstResponder }
		if let activeField = activeField {
			if !aRect.contains(activeField.frame.origin) {
				let scrollPoint = CGPoint(x: 0, y: activeField.frame.origin.y-kbSize.height)
				scrollView.setContentOffset(scrollPoint, animated: true)
			}
		}
	}
	
	@objc func keyboardWillBeHidden(notification: Notification) {
		let contentInsert = UIEdgeInsets.zero
		scrollView.contentInset = contentInsert
	}
}

private extension LoginViewController {
	// MARK: - check login and password
	func checkUserData() -> Bool {
		guard
			let login = loginInput.text,
			let password = passwordInput.text
		else {
			return false
		}
		
		if login == "admin" && password == "1234" {
			return true
		} else {
			return false
		}
	}
	
	// MARK: - Show login error
	func showLoginError() {
		let alert = UIAlertController(title: "Error",
									  message: "Login or password are not correct",
									  preferredStyle: .alert)
		let action  = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
}
