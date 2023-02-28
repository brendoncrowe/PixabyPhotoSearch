//
//  ViewController.swift
//  PixabyPhotoSearch
//
//  Created by Brendon Crowe on 2/8/23.
//

import UIKit

class PhotoSearchController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var photos = [Photo]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private var searchQuery = "welcome" {
        didSet {
            loadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        loadData()
    }
    
    private func loadData() {
        PhotoApiClient.getPhotos(searchQuery: searchQuery) { [weak self] result in
            switch result {
            case .failure:
                print("Error loading photos")
            case .success(let photos):
                DispatchQueue.main.async {
                    self?.photos = photos
                }
            }
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navController = segue.destination as? UINavigationController, let photoDetailVC = navController.viewControllers.first as? PhotoDetailController, let cell = sender as? UICollectionViewCell, let indexPath = collectionView.indexPath(for: cell) else {
            fatalError("could not segue PhotoDetailController")
        }
        photoDetailVC.photo = photos[indexPath.row]

    }
}

extension PhotoSearchController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell else {
            fatalError("could not typecast to a PhotoCell")
        }
        let photo = photos[indexPath.row]
        cell.configureCell(for: photo)
        return cell
    }
}

extension PhotoSearchController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing: CGFloat = 8 // space between items
        let maxWidth = (view.window?.windowScene?.screen.bounds.size.width)! // device's width
        let numberOfItems: CGFloat = 3 // items
        let totalSpacing: CGFloat = numberOfItems * interItemSpacing
        let itemWidth: CGFloat = (maxWidth - totalSpacing) / numberOfItems
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if searchBar.isFirstResponder {
            searchBar.resignFirstResponder()
        }
    }
}

extension PhotoSearchController: UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let searchText = searchBar.text else {
            print("Error getting search text")
            return
        }
        guard !searchText.isEmpty else {
            loadData()
            return
        }
        searchQuery = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "taco"
    }
}

