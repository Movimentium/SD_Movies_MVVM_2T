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
