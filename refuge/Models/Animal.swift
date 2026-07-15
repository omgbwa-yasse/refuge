//
//  Animal.swift
//  refuge
//

import Foundation

// Statut d'adoption d'un animal : peut être basculé depuis la scène de détails (LongPressGesture).
enum AdoptionStatus: String {
    case available = "Disponible pour adoption"
    case adopted = "Adopté"

    // Icône SF Symbols associée à chaque statut, utilisée dans les badges de l'interface.
    var symbolName: String {
        switch self {
        case .available: return "pawprint.circle.fill"
        case .adopted: return "house.fill"
        }
    }
}

// Modèle représentant un animal hébergé par le refuge.
// C'est une struct : les modifications (bien-être, statut) se font via un Binding
// vers le tableau partagé dans AppModel, pour que les changements soient conservés
// quand on revient à la liste puis qu'on rouvre le même animal.
struct Animal: Identifiable {
    let id = UUID()
    var name: String
    var species: String
    var age: Int
    var imageName: String
    var wellbeing: Int // Niveau de bien-être, de 0 à 10
    var adoptionStatus: AdoptionStatus

    // Accord singulier/pluriel de "an(s)" selon l'âge.
    var ageDescription: String {
        age > 1 ? "\(age) ans" : "\(age) an"
    }

    // Message affiché dans la scène de détails, qui décrit l'état de bien-être
    // de l'animal en fonction de son niveau actuel (0 à 10).
    var wellbeingMessage: String {
        switch wellbeing {
        case 0...2:
            return "\(name) traverse une période difficile et a besoin de beaucoup d'attention."
        case 3...4:
            return "\(name) semble inconfortable, davantage de soins l'aideraient."
        case 5...6:
            return "\(name) va plutôt bien, mais profiterait de plus d'attention."
        case 7...8:
            return "\(name) est heureux et en bonne santé."
        default:
            return "\(name) est épanoui et resplendissant de bien-être !"
        }
    }
}

extension Animal {
    // Les six animaux accueillis par le refuge, affichés dans l'onglet "Animaux".
    static let sampleAnimals: [Animal] = [
        Animal(name: "Rex", species: "Chien", age: 3, imageName: "AnimalDog", wellbeing: 7, adoptionStatus: .available),
        Animal(name: "Luna", species: "Chat", age: 2, imageName: "AnimalCat", wellbeing: 8, adoptionStatus: .available),
        Animal(name: "Coco", species: "Lapin", age: 1, imageName: "AnimalRabbit", wellbeing: 6, adoptionStatus: .available),
        Animal(name: "Kiwi", species: "Oiseau", age: 1, imageName: "AnimalBird", wellbeing: 9, adoptionStatus: .adopted),
        Animal(name: "Biscotte", species: "Hamster", age: 1, imageName: "AnimalHamster", wellbeing: 4, adoptionStatus: .available),
        Animal(name: "Shelly", species: "Tortue", age: 5, imageName: "AnimalTurtle", wellbeing: 10, adoptionStatus: .adopted)
    ]
}
