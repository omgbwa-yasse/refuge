//
//  refugeApp.swift
//  refuge
//
//  Created by user295774 on 7/15/26.
//

import SwiftUI

@main
struct refugeApp: App {
    // Une seule instance d'AppModel pour toute l'application, injectée dans
    // l'environnement afin que toutes les vues partagent le même état.
    @State private var appModel = AppModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appModel)
        }
    }
}
