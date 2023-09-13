//
//  swapi_swiftuiApp.swift
//  swapi-swiftui
//
//  Created by Anro Swart on 2023/09/10.
//

import SwiftUI

@main
struct swapi_swiftuiApp: App {
    @ObservedObject private var router = RouterService()
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundImage = UIImage(named: "background")
        appearance.backgroundImageContentMode = .scaleToFill
        appearance.titleTextAttributes = [.foregroundColor: UIColor(cgColor: Color("bananna-yellow").cgColor ?? UIColor.yellow.cgColor)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(cgColor: Color("bananna-yellow").cgColor ?? UIColor.yellow.cgColor)]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(router)
        }
    }
}
