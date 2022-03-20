//
//  PhotosContainer.swift
//  myVKApp
//
//  Created by Sergey Makeev on 08.03.2022.
//

import Foundation

class Photo: Decodable {
	let ownerId: Int
	var albumId: Int
	var photoSizes: [Sizes]

	enum CodingKeys: String, CodingKey {
		case ownerId = "owner_id"
		case albumId = "album_id"
		case photoSizes = "sizes"
	}
	
	struct Sizes: Decodable {
		var height: Int
		var type: String
		var url: String
		var width: Int
	}
}


struct PhotosContainer: Decodable {
	let photos: [Photo]
}

extension PhotosContainer {
	enum CodingKeys: String, CodingKey {
		case response
		enum ItemKeys: String, CodingKey {
			case items
		}
	}
	
	init(from decoder: Decoder) throws {
		let mainContainer = try decoder.container(keyedBy: CodingKeys.self)
//		print("!!!!! \(mainContainer.allKeys)")
		let itemContainer = try mainContainer.nestedContainer(keyedBy: CodingKeys.ItemKeys.self, forKey: .response)
		photos = try itemContainer.decode([Photo].self, forKey: .items)
//		print("!!!!! \(itemContainer.allKeys)")
	}
}
