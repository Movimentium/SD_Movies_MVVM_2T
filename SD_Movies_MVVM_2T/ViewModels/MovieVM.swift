//  MovieVM.swift
//  SD_Movies_MVVM_2T
//  Created by Miguel Gallego on 9/11/25.
import Foundation
import SwiftData

@Observable
final class MovieVM {
    var title = ""
    var year: Int
    
    let years: [Int]
    var showingAddMovie = false
    var movieToUpdate: Movie?
    
    private let modelCtx: ModelContext
    
    init(modelCtx: ModelContext) {
        self.modelCtx = modelCtx
        let maxYear = Calendar.current.component(.year, from: .now)
        years = Array(1850...maxYear)
        year = maxYear - 5
    }
    
    func showAddMovie() {
        showingAddMovie = true
    }

    
    // MARK: DB Methods
    func addMovie() {
        let title = title.trimmingCharacters(in: .whitespaces)
        let newMovie = Movie(title: title, year: year)
        //TODO: add poster
        
        modelCtx.insert(newMovie)
        showingAddMovie = false
    }
    
    func updateMovie() {
        guard let movie = movieToUpdate else { return }
        movie.title = title.trimmingCharacters(in: .whitespaces)
        movie.year = year
        //TODO: update poster

        save()
    }
    
    func deleteMovie(_ movie: Movie) {
        modelCtx.delete(movie)
        save()
    }
    
    private func save() {
        do {
            try modelCtx.save()
            print(Self.self, #function, "OK")
        } catch {
            print(Self.self, #function, "Error saving context: \(error)")
        }
    }
    
}
