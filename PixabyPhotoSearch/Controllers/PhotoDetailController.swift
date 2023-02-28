//
//  PhotoDetailController.swift
//  PixabyPhotoSearch
//
//  Created by Brendon Crowe on 2/27/23.
//

import UIKit

class PhotoDetailController: UIViewController {
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var numberOfViewsLabel: UILabel!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    
    var dataPersistence = DataPersistence<Photo>(filename: "photos.plist")
    
    
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
    }
    
    private func loadUI() {
        guard let photo = photo else { return }
        userIDLabel.text = "Uploaded by user: \(photo.user)"
        numberOfLikesLabel.text = "Number of likes: " + String(photo.likes)
        numberOfViewsLabel.text = "Number of views: " + String(photo.views)
        photoImageView.getImage(with: photo.largeImageURL) { [weak self] result in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.photoImageView.image = UIImage(systemName: "exclamationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.photoImageView.image = image
                }
            }
        }
        photoImageView.layer.cornerRadius = 32
    }
    
    
    
    @IBAction func savePhotoButtonPressed(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Saved", message: "The photo was saved to your favorites", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
        
        //TODO: When save button is pressed, add photo to favorites
        
        do {
            if let photo = photo {
                try dataPersistence.createItem(photo)
                print("photo was successfully saved")
            }
        } catch {
            print("Error saving photo: \(error)")
        }
    }
    
    
    @IBAction func dismissView(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    
}
