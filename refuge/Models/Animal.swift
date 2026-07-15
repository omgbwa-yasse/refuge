//
//  Animal.swift
//  refuge
//

import Foundation

enum AdoptionStatus: String {
    case available = "Disponible pour adoption"
    case adopted = "Adopté"

    var symbolName: String {
        switch self {
        case .available: return "pawprint.circle.fill"
        case .adopted: return "house.fill"
        }
    }
}

struct Animal: Identifiable {
    let id = UUID()
    var name: String
    var species: String
    var age: Int
    var imageName: String
    var wellbeing: Int
    var adoptionStatus: AdoptionStatus

    var ageDescription: String {
        age > 1 ? "\(age) ans" : "\(age) an"
    }

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
    static let sampleAnimals: [Animal] = [
        Animal(name: "Rex", species: "Chien", age: 3, imageName: "AnimalDog", wellbeing: 7, adoptionStatus: .available),
        Animal(name: "Luna", species: "Chat", age: 2, imageName: "AnimalCat", wellbeing: 8, adoptionStatus: .available),
        Animal(name: "Coco", species: "Lapin", age: 1, imageName: "AnimalRabbit", wellbeing: 6, adoptionStatus: .available),
        Animal(name: "Kiwi", species: "Oiseau", age: 1, imageName: "AnimalBird", wellbeing: 9, adoptionStatus: .adopted),
        Animal(name: "Biscotte", species: "Hamster", age: 1, imageName: "AnimalHamster", wellbeing: 4, adoptionStatus: .available),
        Animal(name: "Shelly", species: "Tortue", age: 5, imageName: "AnimalTurtle", wellbeing: 10, adoptionStatus: .adopted)
    ]
}
