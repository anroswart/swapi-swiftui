//
//  RouterService.swift
//  swapi-swiftui
//
//  Created by Anro Swart on 2023/09/11.
//

import SwiftUI

class RouterService: ObservableObject {
    var viewStack = [AnyView]()
    @Published var currentView: AnyView?

    func push<Content: View>(_ view: Content) {
        currentView = AnyView(view)
        viewStack.append(AnyView(view))
    }

    func pop() {
        viewStack.removeLast()
        currentView = viewStack.isEmpty ? nil : viewStack.last
    }
}

