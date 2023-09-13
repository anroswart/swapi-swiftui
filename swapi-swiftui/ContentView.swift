//
//  ContentView.swift
//  swapi-swiftui
//
//  Created by Anro Swart on 2023/09/10.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var router: RouterService

    var body: some View {
        NavigationView {
            router.currentView ?? AnyView(SplashScreenView())
        }
    }
}
