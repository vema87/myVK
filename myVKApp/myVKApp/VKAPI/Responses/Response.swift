//
//  Response.swift
//  myVKApp
//
//  Created by Sergey Makeev on 01.03.2022.
//

import Foundation

struct Response: Codable {
	var response: Item
}

struct Item: Codable {
	var count: Int
	var items: [Friend]
}
