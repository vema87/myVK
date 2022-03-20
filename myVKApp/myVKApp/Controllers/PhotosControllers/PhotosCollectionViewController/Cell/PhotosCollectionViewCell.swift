//
//  PhotosCollectionViewCell.swift
//  myVKApp
//
//  Created by Sergey Makeev on 07.03.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
	@IBOutlet weak var photoImageView: UIImageView!
	
	override func prepareForReuse() {
		photoImageView.image = nil
	}
	
//	override init(frame: CGRect) {
//		super.init(frame: frame)
//
//		let photo = UIImageView()
//
//		photo.translatesAutoresizingMaskIntoConstraints = false
//
//	}
//
}
