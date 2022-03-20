//
//  Session.swift
//  myVKApp
//
//  Created by Sergey Makeev on 10.01.2022.
//

import Foundation


/// Singleton for session data storage
class Session {
	static let shared = Session()
	
	var token: String = ""
	var userID: Int = 0
	
	private init() {}
}
