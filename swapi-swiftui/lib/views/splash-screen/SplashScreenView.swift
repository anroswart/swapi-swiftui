//
//  SplashScreenView.swift
//  swapi-swiftui
//
//  Created by Anro Swart on 2023/09/11.
//

import SwiftUI

struct SplashScreenView: View {
    @EnvironmentObject
    private var router: RouterService
    
    @State
    private var scale = 1.0
    
    @State
    private var rotation: Double = 0.0
    
    @ObservedObject
    private var viewModel = SplashScreenViewModel()
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Image("splash-background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .task {
                        await viewModel.getFilmData()
                        router.push(
                            FilmListView(films: viewModel.films)
                                .environmentObject(router)
                        )
                    }
                
                VStack {
                    Spacer()
                    Image("splash-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width - 160)
                        .rotationEffect(.degrees(rotation))
                        .scaleEffect(scale)
                        .onAppear {
                            let baseAnimation = Animation.easeInOut(duration: 3)
                            let repeated = baseAnimation.repeatForever(autoreverses: true)
                            
                            withAnimation(repeated) {
                                scale = 1.5
                                rotation = 360
                            }
                        }
                    Spacer()
                    Text("Loading...")
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            }
        }
        .alert(isPresented: $viewModel.showErrorAlert) {
            Alert(
                title: Text("Something went wrong"),
                message: Text(viewModel.errorMessage),
                primaryButton: .default(
                    Text("Try again"),
                    action: {
                        Task {
                            await viewModel.getFilmData()
                        }
                    }
                ),
                secondaryButton: .cancel()
            )
        }
    }
}


struct SplashLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
