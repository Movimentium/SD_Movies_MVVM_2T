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
        
        
        if let _ = fetchMovie(title: title, year: year) {
            print("The movie \(title), \(year) already exists!!!")
            return
        }
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
    
    func fetchMovie(title: String, year: Int) -> Movie? {
        let predicate = #Predicate<Movie> { $0.title == title && $0.year == year }
        let descriptor = FetchDescriptor<Movie>(predicate: predicate)
        if let movies = try? modelCtx.fetch(descriptor), let movie = movies.first  {
            return movie
        }
        return nil
    }

    private func save() {
        do {
            try modelCtx.save()
            print(Self.self, #function, "OK")
        } catch {
            print(Self.self, #function, "Error saving context: \(error)")
        }
    }
    
    // MARK: DB Methods
    #if DEBUG
    func debug_insertMockData() {
        Movie.movies.forEach { modelCtx.insert($0) }
    }
    
    func debug_deleteMockData() {
        Movie.movies.forEach { modelCtx.delete($0) }
        Actor.actors.forEach { modelCtx.delete($0) }
        save()
    }
    
    #endif
}
