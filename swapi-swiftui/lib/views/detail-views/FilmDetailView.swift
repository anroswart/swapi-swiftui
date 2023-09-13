//
//  FilmDetailView.swift
//  swapi-swiftui
//
//  Created by Anro Swart on 2023/09/13.
//

import SwiftUI

struct FilmDetailView: View {
    @EnvironmentObject var router: RouterService
    let film: Film
    private let placeholderImage = UIImage(systemName: "exclamationmark.triangle")!
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray)
                .shadow(radius: 5)
                .overlay(
                    VStack(spacing: 10) {
                        Image(uiImage: UIImage(data: film.posterData ?? Data()) ?? placeholderImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 150)
                            .cornerRadius(10)
                        
                        Text(film.title ?? "TBA")
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .padding(.horizontal, 10)
                        
                        Text("Release Date: \(film.releaseDate ?? "")")
                            .font(.subheadline)
                        
                        Text("Directors: \(film.director ?? "")")
                            .font(.subheadline)
                        
                        Text("Producers: \(film.producer ?? "")")
                            .font(.subheadline)
                        
                        Button {
                            router.push(
                                CharactersView(characters: film.characterList ?? ["No data"])
                                    .environmentObject(router)
                            )
                        } label: {
                            Text("View film characters")
                                .foregroundColor(Color("bananna-yellow"))
                        }
                    }
                        .padding()
                )
                .padding(EdgeInsets(top: 40, leading: 16, bottom: 40, trailing: 16))
            
            Button(action: {
                router.pop()
            }) {
                Image(systemName: "xmark")
                    .font(.title)
                    .foregroundColor(.red)
                    .padding()
            }
            .padding(EdgeInsets(top: 56, leading: 0, bottom: 0, trailing: 32))
        }
        .navigationBarBackButtonHidden(true)
        .background {
            Image("background")
                .scaledToFit()
                .ignoresSafeArea()
        }
    }
}

struct FilmDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FilmDetailView(film: Film(title: "Film title test", releaseDate: "2023-01-01", director: "Mr Bean", producer: "Also Mr Bean", openingCrawl: "Lorem ipsum?", characterURLs: [""]))
    }
}
