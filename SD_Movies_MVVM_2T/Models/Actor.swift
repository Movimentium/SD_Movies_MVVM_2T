//  Actor.swift
//  SD_Movies_MVVM_2T
//  Created by Miguel Gallego on 9/11/25.
import Foundation
import SwiftData
import SwiftUI


@Model
final class Actor {
    var name: String
    var yearOfBirth: Int?
    var movies: [Movie] = []
    @Attribute(.externalStorage)
    var imgData: Data?

    init(name: String, yearOfBirth: Int? = nil) {
        self.name = name
        self.yearOfBirth = yearOfBirth
    }
}


// MARK: - Presentation properties
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
