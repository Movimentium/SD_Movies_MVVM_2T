//  SD_Movies_MVVM_2TApp.swift
//  SD_Movies_MVVM_2T
//  Created by Miguel Gallego on 9/11/25.
import SwiftUI
import SwiftData

@main
struct SD_Movies_MVVM_2TApp: App {
    
    let modelContainer: ModelContainer
    
    init() {
        modelContainer = SDProvider().modelContainer
        
    }
    
    var body: some Scene {
        WindowGroup {
            DebugScreen()
        }
    }
}
