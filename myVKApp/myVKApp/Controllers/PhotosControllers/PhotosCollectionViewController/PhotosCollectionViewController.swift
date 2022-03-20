//
//  PhotosCollectionViewController.swift
//  myVKApp
//
//  Created by Sergey Makeev on 07.03.2022.
//

import UIKit

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
		
		
//		self.collectionView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return self.photos.count
//    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCellID", for: indexPath) as? PhotosCollectionViewCell
		else {
			return UICollectionViewCell()
		}
		
		let url = URL(string: photos[indexPath.row].photoSizes[1].url)
		if let data = try? Data(contentsOf: url!) {
			photoCell.photoImageView.image = UIImage(data: data)
		}
    
        // Configure the cell
    
        return photoCell
    }
	
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
