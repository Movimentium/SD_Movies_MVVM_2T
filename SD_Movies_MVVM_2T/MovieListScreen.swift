//  MovieListScreen.swift
//  SD_Movies_MVVM_2T
//  Created by Miguel Gallego on 9/11/25.
import SwiftUI
import SwiftData

struct MovieListScreen: View {
    @Environment(MovieVM.self) private var vm
    @Query(sort: \Movie.title, order: .forward) private var movies: [Movie]
    
    var body: some View {
        @Bindable var bindableVM = vm
        
        List {
            ForEach(movies) { m in
                NavigationLink(value: m) {
                    HStack(alignment: .top) {
                        Image(uiImage: m.img)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                        VStack(alignment: .leading) {
                            Text(m.title).bold()
                            Text(m.strYear).font(.caption)
                        }
                    }
                }
            }
            .onDelete { $0.forEach{ vm.deleteMovie(movies[$0])}}
        }
        .navigationBarTitle("Movies")
        .navigationDestination(for: Movie.self) { movie in
            Text(movie.title)  //TODO: MovieDetailScreen
        }
        .toolbar {
            ToolbarItem {
                Button { vm.showAddMovie() } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $bindableVM.showingAddMovie) {
            Text("Add Movie") //TODO: AddMovieScreen
        }        
    }
}

#Preview {
    NavigationStack {
        MovieListScreen()
    }
    .modelContainer(.fakeModelContainerWithData())
    .environment(MovieVM(modelCtx: .fakeModelCtx))
}
