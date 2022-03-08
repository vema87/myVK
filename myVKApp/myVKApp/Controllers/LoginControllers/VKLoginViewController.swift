//
//  VKLoginViewController.swift
//  myVKApp
//
//  Created by Sergey Makeev on 13.01.2022.
//

import UIKit
import WebKit

class VKLoginViewController: UIViewController {

	@IBOutlet weak var vkLoginWebView: WKWebView! {
		didSet {
			vkLoginWebView.navigationDelegate = self
		}
	}
	var session = Session.shared
	
	override func viewDidLoad() {
        super.viewDidLoad()
		auth()
        // Do any additional setup after loading the view.
    }
}

private extension VKLoginViewController {
	func auth() {
		var urlComponents = URLComponents()
		
		urlComponents.scheme = "https"
		urlComponents.host = "oauth.vk.com"
		urlComponents.path = "/authorize"
		urlComponents.queryItems = [
			URLQueryItem(name: "client_id", value: "8049288"),
			URLQueryItem(name: "display", value: "mobile"),
			URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
		]
		
		let request = URLRequest(url: urlComponents.url!)
		vkLoginWebView.load(request)
	}
}

extension VKLoginViewController: WKNavigationDelegate {
	func webView(_ webView: WKWebView,
				 decidePolicyFor navigationResponse: WKNavigationResponse,
				 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
			guard
				let url = navigationResponse.response.url,
				url.path == "/blank.html",
				let fragment = url.fragment
			else {
				decisionHandler(.allow)
				return
			}
			
			let params = fragment
				.components(separatedBy: "&")
				.map{ $0.components(separatedBy: "=")}
				.reduce([String:String]()) { result, param in
					var dict = result
					let key = param[0]
					let value = param[1]
					dict[key] = value
					return dict
				}
				
				if let token = params["access_token"],
					let userId = params["user_id"] {
					session.token = token
					session.userID = userId
					performSegue(withIdentifier: "login", sender: self)
				}
				decisionHandler(.cancel)
				
				// test of VK API:
//				VkService.shared.getFriends(Session.shared.userID)
				VkService.shared.getUserPhotos(Session.shared.userID)
//				VkService.shared.getUserGroupsList(Session.shared.userID)
//				VkService.shared.getGroupDataByString("just Story")
	}
}
