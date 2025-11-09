//  SDProvider.swift
//  SD_Movies_MVVM_2T
//  Created by Miguel Gallego on 9/11/25.
import Foundation
import SwiftData

@MainActor
final class SDProvider {
    let modelContainer: ModelContainer
    let modelCtx: ModelContext
    
    init(_ isInMemoryOnly: Bool = false) {
        let schema = Schema([Movie.self, Actor.self])
        let modelConfig = ModelConfiguration("SDMoviesDB", schema: schema, isStoredInMemoryOnly: isInMemoryOnly)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: modelConfig)
            modelCtx = modelContainer.mainContext
        } catch {
            fatalError("\(Self.self) \(#function) ModelContainer could NOT be initialized: \(error)")
        }
    }
    
}

#if DEBUG
// Things for Previews
extension ModelContext {
    @MainActor
    static let fakeModelCtx = ModelContainer.fakeModelContainer.mainContext
}

@MainActor
extension ModelContainer {
    static let fakeModelContainer = SDProvider(true).modelContainer
    
    static func fakeModelContainerWithData(_ isInMemoryOnly: Bool = true) -> ModelContainer {
        Self.insertFakeData()
        return Self.fakeModelContainer
    }
    
    static func insertFakeData() {
        Movie.movies.forEach { Self.fakeModelContainer.mainContext.insert($0) }
    }
}
 
extension Movie {
    static let movies: [Movie] = {
        let movies = [
            Movie(title: "Batman", year: 1989),
            Movie(title: "Memento", year: 2000)
        ]
        movies[0].actors = [Actor.actors[0], Actor.actors[1]]
        movies[1].actors = [Actor.actors[2], Actor.actors[3]]
        
        return movies
    }()
}

extension Actor {
    static let actors = [
        Actor(name: "Michael Keaton"),
        Actor(name: "Jack Nicholson"),
        Actor(name: "Carrie-Anne Moss"),
        Actor(name: "Guy Pearce")
    ]
}

#endif

