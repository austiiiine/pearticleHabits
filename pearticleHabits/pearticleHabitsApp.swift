//
//  pearticleHabitsApp.swift
//  pearticleHabits
//
//  Created by Austine Huang on 2025/12/13.
//

import SwiftUI

@main
struct pearticleHabitsApp: App {
    @State private var appModel = AppModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
            .environment(appModel)
        }
    }
}
