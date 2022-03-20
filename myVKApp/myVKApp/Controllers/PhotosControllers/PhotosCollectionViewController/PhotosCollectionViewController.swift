//
//  PhotosCollectionViewController.swift
//  myVKApp
//
//  Created by Sergey Makeev on 07.03.2022.
//

import UIKit
import Kingfisher
import RealmSwift

class PhotosCollectionViewController: UICollectionViewController {

	private var photos = [Photo]()
	var friendID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        if let friendID = self.friendID {
			VkService.shared.getUserPhotos(friendID) { [weak self] photosList in
				DispatchQueue.main.async {
					self?.savePhotos(photosList)
					self?.photos = self!.getPhotosFromRealm(friendId: friendID)
					self?.collectionView.reloadData()
				}
			}
		}
    }
    
    func savePhotos(_ data: [Photo]) {
		do {
			// create realm (do-catch is mandatory)
			let realm = try Realm()
			//write to DB:
			realm.beginWrite()
			realm.add(data)
			try realm.commitWrite()
		} catch {
			print(error)
		}
	}

	func getPhotosFromRealm(friendId: Int) -> [Photo] {
		var photos = [Photo]()
		do {
			let realm = try Realm()
			let photosData = realm.objects(Photo.self).filter("ownerId = \(friendId)")
			photos = Array(photosData)
		} catch {
			print(error)
		}
		return photos
	}
	

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCellID", for: indexPath) as? PhotosCollectionViewCell
		else {
			return UICollectionViewCell()
		}
		
		photoCell.photoImageView.kf.setImage(with: URL(string: photos[indexPath.row].photoUrl))
		
//		another way: download photo via swift:
//		if let data = try? Data(contentsOf: url!) {
//			photoCell.photoImageView.image = UIImage(data: data)
//		}
    
        return photoCell
    }

}
