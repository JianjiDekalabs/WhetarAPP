//
//  Wheater_APPApp.swift
//  Wheater APP
//
//  Created by Jianji Zhong Huang on 5/10/24.
//

import SwiftUI

@main
struct Wheater_APPApp: App {
    @StateObject var listOfCities: ListaViewModel = ListaViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(listOfCities)
        }
    }
}
