//  AddMovieScreen.swift
//  SD_Movies_MVVM_2T
//  Created by Miguel Gallego on 18/11/25.
import SwiftUI

struct AddMovieScreen: View {
    
    @Environment(MovieVM.self) private var vm
    
    var body: some View {
        @Bindable var bindableVM = vm
        
        Form {
            VStack(alignment: .leading, spacing: 8) {
                Text("Title").font(.headline)
                TextField("Title", text: $bindableVM.title)
            }
            Picker(selection: $bindableVM.year) {
                ForEach(vm.years, id: \.self) { year in
                    Text(year.description).tag(year)
                }
            } label: {
                Text("Year").font(.headline)
            }
        }
        .navigationTitle("Add Movie")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    vm.showingAddMovie = false
                } label: {
                    Image(systemName: "xmark")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    vm.addMovie()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddMovieScreen()
            .environment(MovieVM(modelCtx: .fakeModelCtx))
    }
}
