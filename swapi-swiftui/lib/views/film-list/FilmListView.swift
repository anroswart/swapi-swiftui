//
//  FilmListView.swift
//  swapi-swiftui
//
//  Created by Anro Swart on 2023/09/13.
//

import SwiftUI

struct FilmListView: View {
    @EnvironmentObject var router: RouterService
    let films: [Film]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(films) { film in
                    if let imageData = film.posterData {
                        FilmPosterView(movieTitle: film.title ?? "TBA",
                                       imageData: imageData)
                        .onTapGesture {
                            router.push(
                                FilmDetailView(film: film)
                                    .environmentObject(router)
                            )
                        }
                    }
                }
            }
            .padding(10)
        }
        .navigationBarTitle("Star Wars Films")
        .background {
            Image("background")
                .scaledToFit()
                .ignoresSafeArea()
        }
    }
}

struct FilmListView_Previews: PreviewProvider {
    static var previews: some View {
        FilmListView(films: [Film(title: "Film title test", releaseDate: "2023-01-01", director: "Mr Bean", producer: "Also Mr Bean", openingCrawl: "Lorem ipsum?", characterURLs: [""])])
    }
}
