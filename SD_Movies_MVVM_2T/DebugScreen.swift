//  DebugScreen.swift
//  SD_Movies_MVVM_2T
//  Created by Miguel Gallego on 9/11/25.
import SwiftUI
import SwiftData

struct DebugScreen: View {
    @Environment(MovieVM.self) private var movieVM
    @Query(sort: \Movie.title, order: .forward) private var movies: [Movie]
    @Query(sort: \Actor.name, order: .forward) private var actors: [Actor]
    
    var body: some View {
        
        List {
            Section("Movies") {
                ForEach(movies) { m in
                    VStack(alignment: .leading) {
                        Text(m.title).bold()
                        ForEach(m.actors) { a in
                            Text(a.name).font(.caption2)
                        }
                    }
                }
            }
         
            Section("Actors") {
                ForEach(actors) { a in
                    VStack(alignment: .leading) {
                        Text(a.name).bold()
                        ForEach(a.movies) { m in
                            Text(m.title).font(.caption2)
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Debug")
       
    }
}

#Preview {
    NavigationStack {
        DebugScreen()
    }
    .modelContainer(.fakeModelContainerWithData())
    .environment(MovieVM(modelCtx: .fakeModelCtx))
}
