//
//  PhotosContainer.swift
//  myVKApp
//
//  Created by Sergey Makeev on 08.03.2022.
//

import Foundation
import RealmSwift

class PhotosContainer {
	var response = [Photo]()
	
	static func map(_ dict: [String: Any]) -> PhotosContainer {
		let resp = PhotosContainer()
		if let data = dict["response"] as? [String:Any] {
			if let items = data["items"] as? [[String: Any]] {
				resp.response = items.map({
					Photo.map($0)
				})
			}
		}
		
		return resp
	}
}

class Photo: Object {
	@objc dynamic var ownerId: Int = 0
	@objc dynamic var albumId: Int = 0
//	var photoSizes: [Sizes] = []
	@objc dynamic var photoUrl: String = ""
	
//	struct Sizes {
//		var height: Int
//		var type: String
//		var url: String
//		var width: Int
//	}

	static func map(_ dict: [String: Any]) -> Photo {
		let photo = Photo()
		
		if let ownerDataId = dict["owner_id"] as? Int { photo.ownerId = ownerDataId }
		if let albumDataId = dict["album_id"] as? Int { photo.albumId = albumDataId }
		if let photoDataSizes = dict["sizes"] as? [[String: Any]] {
			if let url = photoDataSizes[1]["url"] as? String { photo.photoUrl = url }
		}
		//photo.photoSizes = photoDataSizes }
		
		return photo
	}
}


//class Photo: Decodable {
//	let ownerId: Int
//	var albumId: Int
//	var photoSizes: [Sizes]
//
//	enum CodingKeys: String, CodingKey {
//		case ownerId = "owner_id"
//		case albumId = "album_id"
//		case photoSizes = "sizes"
//	}
//	
//	struct Sizes: Decodable {
//		var height: Int
//		var type: String
//		var url: String
//		var width: Int
//	}
//}
//
//
//struct PhotosContainer: Decodable {
//	let photos: [Photo]
//}
//
//extension PhotosContainer {
//	enum CodingKeys: String, CodingKey {
//		case response
//		enum ItemKeys: String, CodingKey {
//			case items
//		}
//	}
//	
//	init(from decoder: Decoder) throws {
//		let mainContainer = try decoder.container(keyedBy: CodingKeys.self)
////		print("!!!!! \(mainContainer.allKeys)")
//		let itemContainer = try mainContainer.nestedContainer(keyedBy: CodingKeys.ItemKeys.self, forKey: .response)
//		photos = try itemContainer.decode([Photo].self, forKey: .items)
//	}
//}
