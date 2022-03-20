//
//  PhotosCollectionViewController.swift
//  myVKApp
//
//  Created by Sergey Makeev on 07.03.2022.
//

import UIKit
import Kingfisher

//private let reuseIdentifier = "Cell"

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
					guard let self = self else { return }
					self.photos = photosList
					self.collectionView.reloadData()
				}
			}
		}
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCellID", for: indexPath) as? PhotosCollectionViewCell
		else {
			return UICollectionViewCell()
		}
		
		let url = URL(string: photos[indexPath.row].photoSizes[1].url)
		photoCell.photoImageView.kf.setImage(with: url)
		
//		another way: download photo via swift:
//		if let data = try? Data(contentsOf: url!) {
//			photoCell.photoImageView.image = UIImage(data: data)
//		}
    
        return photoCell
    }

}
