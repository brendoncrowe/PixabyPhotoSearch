//
//  FileManager Extension.swift
//  PixabyPhotoSearch
//
//  Created by Brendon Crowe on 2/8/23.
//

import Foundation


public enum Directory {
  case documentsDirectory
  case cachesDirectory
}

extension FileManager {
  public static func getDocumentsDirectory() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
  
  public static func getCachesDirectory() -> URL {
    return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
  }
  
  public static func getPath(with filename: String, for directory: Directory) -> URL {
    switch directory {
    case .cachesDirectory:
      return getCachesDirectory().appendingPathComponent(filename)
    case .documentsDirectory:
      return getDocumentsDirectory().appendingPathComponent(filename)
    }
  }
}
