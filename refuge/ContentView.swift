//
//  ContentView.swift
//  refuge
//

import SwiftUI

struct ContentView: View {
    @Environment(AppModel.self) private var appModel

    var body: some View {
        @Bindable var appModel = appModel

        TabView(selection: $appModel.selectedTab) {
            AnimalListView()
                .tabItem {
                    Label("Animaux", systemImage: "pawprint.fill")
                }
                .tag(AppTab.animals)

            ShelterView()
                .tabItem {
                    Label("Le refuge", systemImage: "house.fill")
                }
                .tag(AppTab.shelter)
        }
    }
}

#Preview {
    ContentView()
        .environment(AppModel())
}
