//
//  PhotAPIClient.swift
//  PixabyPhotoSearch
//
//  Created by Brendon Crowe on 2/8/23.
//

import Foundation

struct PhotoApiClient {
    static func getPhotos(searchQuery: String, completion: @escaping (Result<[Photo], AppError>)-> ()) {
        
        let endpoint = "https://pixabay.com/api/?key=33354910-2fec5a9935c10445b9f7d6f62&q=\(searchQuery)&per_page=60"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL(endpoint)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                // network error
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    // parse data
                    let results = try JSONDecoder().decode(PhotoSearch.self, from: data)
                    let photos = results.hits
                    completion(.success(photos))
                    
                } catch {
                    // decoding error
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
}
