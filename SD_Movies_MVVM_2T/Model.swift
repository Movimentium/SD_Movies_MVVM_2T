//  Model.swift
//  SD_Movies_MVVM_2T
//  Created by Miguel Gallego on 9/11/25.
import Foundation
import SwiftData
import SwiftUI

@Model
final class Movie {
    var title: String
    var year: Int
    @Attribute(.externalStorage) var imgData: Data?
    
    
    
    init(title: String, year: Int) {
        self.title = title
        self.year = year
    }
}

@Model
final class Actor {
    var name: String
    var yearOfBirth: Int?
    @Attribute(.externalStorage) var imgData: Data?

    
    
    init(name: String, yearOfBirth: Int? = nil) {
        self.name = name
        self.yearOfBirth = yearOfBirth
    }
}

// MARK: - Presentation properties
extension Movie {
    var strYear: String {
        year.description
    }
    
    var img: Image? {
        if let data = imgData, let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        }
        return nil  // TODO: return a placeholder
    }
}


extension Actor {
    var strYearOfBirth: String {
        yearOfBirth?.description ?? "N/A"
    }
    
    var img: Image? {
        if let data = imgData, let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        }
        return nil  // TODO: return a placeholder
    }
}

