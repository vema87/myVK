//
//  MyFriendViewController.swift
//  myVKApp
//
//  Created by Sergey Makeev on 09.12.2021.
//

import UIKit

class MyFriendViewController: UIViewController {
	
	@IBOutlet weak var likeControl: LikeControl!
	@IBOutlet weak var myFriendView: MyFriendView!
	var image: UIImage?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		if let img = image {
			myFriendView.setImage(img)
		}
	}
	
}

