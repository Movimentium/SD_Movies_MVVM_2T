//  SD_Movies_MVVM_2TApp.swift
//  SD_Movies_MVVM_2T
//  Created by Miguel Gallego on 9/11/25.
import SwiftUI
import SwiftData

@main
struct SD_Movies_MVVM_2TApp: App {
    
    let modelContainer: ModelContainer
    let movieVM: MovieVM
    
    init() {
        modelContainer = SDProvider().modelContainer
        movieVM = MovieVM(modelCtx: modelContainer.mainContext)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MovieListScreen()
//                DebugScreen()
            }
        }
        .modelContainer(modelContainer)
        .environment(movieVM)
    }
}
