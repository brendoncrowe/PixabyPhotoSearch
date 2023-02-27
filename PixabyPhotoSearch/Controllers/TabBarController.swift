//
//  TabBarController.swift
//  PixabyPhotoSearch
//
//  Created by Brendon Crowe on 2/26/23.
//

import UIKit

class TabBarController: UITabBarController {
    
private let dataPersistence = DataPersistence<Photo>(filename: "photos.plist")
    
    private lazy var photoSearchNavController: UINavigationController = {
        guard let navController = storyboard?.instantiateViewController(withIdentifier: "PhotoSearchNavController") as? UINavigationController, let photoSearchController = navController.viewControllers.first as? PhotoSearchController else {
            fatalError("Could not load PhotoSearchNavController ")
        }
        return navController
    }()
    
    private lazy var favoritesNavController: UINavigationController = {
        guard let navController = storyboard?.instantiateViewController(withIdentifier: "FavoritesNavController") as? UINavigationController, let favoritesPhotoController = navController.viewControllers.first as? FavoritesController else {
            fatalError("Could not load FavoritesNavController ")
        }
        return navController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [photoSearchNavController, favoritesNavController]
    }


}
