//
//  PhotoCell.swift
//  PixabyPhotoSearch
//
//  Created by Brendon Crowe on 2/22/23.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    public func configureCell(for photo: Photo) { // [weak self] is a capture list used to break strong reference cycle
        photoImageView.getImage(with: photo.largeImageURL) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.photoImageView.image = image
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.photoImageView.image = UIImage(systemName: "exclamationmark.triangle")
                }
            }
        }
        photoImageView.layer.cornerRadius = 16
    }
}
