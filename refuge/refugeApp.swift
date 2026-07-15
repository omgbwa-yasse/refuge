//
//  refugeApp.swift
//  refuge
//
//  Created by user295774 on 7/15/26.
//

import SwiftUI

@main
struct refugeApp: App {
    @State private var appModel = AppModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appModel)
        }
    }
}
