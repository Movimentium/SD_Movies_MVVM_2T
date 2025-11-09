//  Movie.swift
//  SD_Movies_MVVM_2T
//  Created by Miguel Gallego on 9/11/25.
import Foundation
import SwiftData
import SwiftUI

@Model
final class Movie {
    var title: String
    var year: Int
    @Attribute(.externalStorage)
    var imgData: Data?
    
    @Relationship(deleteRule: .nullify, inverse: \Actor.movies)
    var actors: [Actor] = []
    
    init(title: String, year: Int) {
        self.title = title
        self.year = year
    }
}


// MARK: - Presentation properties
extension Movie {
    var strYear: String {
        year.description
    }
    
    var img: UIImage {
        if let data = imgData, let uiImage = UIImage(data: data) {
            return uiImage
        }
        return UIImage(systemName: "photo")!  //TODO: TEST
    }
}
