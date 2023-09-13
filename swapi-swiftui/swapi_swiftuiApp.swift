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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(router)
        }
    }
}
