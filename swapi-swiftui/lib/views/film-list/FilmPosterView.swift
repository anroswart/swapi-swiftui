//
//  FilmPosterView.swift
//  swapi-swiftui
//
//  Created by Anro Swart on 2023/09/13.
//

import SwiftUI

struct FilmPosterView: View {
    let movieTitle: String
    let imageData: Data
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Image(uiImage: UIImage(data: imageData) ?? UIImage(systemName: "exclamationmark.triangle")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(5)
                    .shadow(radius: 5)
                    .frame(maxHeight: UIScreen.main.bounds.height - 160)
                
                Text(movieTitle)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 16)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
            }
            .padding()
        }
        .frame(maxWidth: UIScreen.main.bounds.width - 32)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

struct FilmPosterView_Previews: PreviewProvider {
    static var previews: some View {
        FilmPosterView(movieTitle: "TBA", imageData: (UIImage(named: "sw-splash")?.pngData())!)
    }
}
