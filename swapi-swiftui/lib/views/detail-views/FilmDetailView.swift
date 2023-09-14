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
    @State private var yOffset: CGFloat = 540
    private let scrollDistance: CGFloat = 720
    private let placeholderImage = UIImage(systemName: "exclamationmark.triangle")!
    
    var body: some View {
        ZStack(alignment: .top) {
            infoCard
                .padding(EdgeInsets(top: 160, leading: 16, bottom: 40, trailing: 16))
                .zIndex(1)
            
            openingCrawl
                .zIndex(0)
        }
        .navigationBarBackButtonHidden(true)
        .background {
            Image("background")
                .scaledToFit()
                .ignoresSafeArea()
        }
    }
    
    private var infoCard: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 10) {
                Image(uiImage: UIImage(data: film.posterData ?? Data()) ?? placeholderImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 160)
                    .cornerRadius(10)
                
                Text(film.title ?? "TBA")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.horizontal, 8)
                
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
                .padding(.bottom)
            }
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray)
                    .shadow(radius: 5)
            }
            
            Button(action: {
                router.pop()
            }) {
                Image(systemName: "xmark")
                    .font(.title)
                    .foregroundColor(.red)
                    .padding()
            }
            .padding()
        }
    }
    
    private var openingCrawl: some View {
        let leadingSpace = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
        return VStack {
            Text("\(leadingSpace)\(film.openingCrawl ?? "")")
                .fontWeight(.bold)
                .font(.subheadline)
                .foregroundColor(Color("bananna-yellow"))
                .multilineTextAlignment(.center)
                .lineSpacing(8)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxHeight: .infinity)
                .offset(y: yOffset)
                .animation(.linear(duration: 45).repeatForever(autoreverses: false), value: UUID())
                .onAppear {
                    self.yOffset = -scrollDistance
                }
        }
        .rotation3DEffect(.degrees(60), axis: (x: 1, y: 0, z: 0))
    }
}

struct FilmDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FilmDetailView(film: Film(title: "Film title test", releaseDate: "2023-01-01", director: "Mr Bean", producer: "Also Mr Bean", openingCrawl: "Lorem ipsum?", characterURLs: [""]))
    }
}
