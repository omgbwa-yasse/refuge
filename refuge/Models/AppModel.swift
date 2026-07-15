//
//  AppModel.swift
//  refuge
//

import SwiftUI

// Les deux onglets du TabView racine.
enum AppTab: Hashable {
    case shelter
    case animals
}

// État partagé de l'application, injecté dans l'environnement (voir refugeApp.swift).
// Centraliser ici l'onglet sélectionné et la liste des animaux permet :
// - à ShelterView de changer d'onglet quand on touche "Animaux accueillis" ;
// - aux modifications faites dans AnimalDetailView (bien-être, statut) de rester
//   visibles quand on revient à la liste puis qu'on rouvre le même animal.
@Observable
final class AppModel {
    // .shelter par défaut : l'application doit démarrer sur l'onglet "Le refuge".
    var selectedTab: AppTab = .shelter
    var animals: [Animal] = Animal.sampleAnimals
    let shelter = Shelter.current

    // Appelé quand l'utilisateur touche la section "Animaux accueillis" du refuge.
    func openAnimalsTab() {
        selectedTab = .animals
    }
}
