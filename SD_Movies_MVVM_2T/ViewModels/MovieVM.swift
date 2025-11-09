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
    var showAddMovie = false

    
    private let modelCtx: ModelContext
    
    init(modelCtx: ModelContext) {
        self.modelCtx = modelCtx
        let maxYear = Calendar.current.component(.year, from: .now)
        years = Array(1850...maxYear)
        year = maxYear - 5
    }
}
