//
//  ContentView.swift
//  refuge
//

import SwiftUI

struct ContentView: View {
    @Environment(AppModel.self) private var appModel

    var body: some View {
        // @Bindable permet de créer un Binding ($appModel.selectedTab) à partir
        // d'un objet @Observable reçu par @Environment.
        @Bindable var appModel = appModel

        // TabView racine : la sélection est liée à appModel.selectedTab, ce qui
        // permet à ShelterView de changer d'onglet par programmation.
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
