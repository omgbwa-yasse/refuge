//
//  AppModel.swift
//  refuge
//

import SwiftUI

enum AppTab: Hashable {
    case shelter
    case animals
}

@Observable
final class AppModel {
    var selectedTab: AppTab = .shelter
    var animals: [Animal] = Animal.sampleAnimals
    let shelter = Shelter.current

    func openAnimalsTab() {
        selectedTab = .animals
    }
}
