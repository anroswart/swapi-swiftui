//
//  CharactersView.swift
//  swapi-swiftui
//
//  Created by Anro Swart on 2023/09/13.
//

import SwiftUI

struct DarkListStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowBackground(Color.black)
            .listRowSeparatorTint(Color("bananna-yellow"))
    }
}

struct CharactersView: View {
    @EnvironmentObject private var router: RouterService
    let characters: [String]
    
    var body: some View {
        List {
            ForEach(characters, id: \.self) { character in
                Text(character)
                    .foregroundColor(Color("bananna-yellow"))
                    .modifier(DarkListStyle()) 
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            router.pop()
        }, label: {
            Text("Back")
                .foregroundColor(Color("bananna-yellow"))
        }))
        .background {
            Image("background")
                .scaledToFit()
                .ignoresSafeArea()
        }
        .scrollContentBackground(.hidden)
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView(characters: ["Test1", "Test2"])
    }
}
