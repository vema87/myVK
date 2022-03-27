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
	@objc dynamic var photoUrl: String = ""

	static func map(_ dict: [String: Any]) -> Photo {
		let photo = Photo()
		
		if let ownerDataId = dict["owner_id"] as? Int { photo.ownerId = ownerDataId }
		if let albumDataId = dict["album_id"] as? Int { photo.albumId = albumDataId }
		if let photoDataSizes = dict["sizes"] as? [[String: Any]] {
			if let url = photoDataSizes[1]["url"] as? String { photo.photoUrl = url }
		}
		
		return photo
	}
}
