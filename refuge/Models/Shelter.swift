//
//  Shelter.swift
//  refuge
//

import Foundation

// Informations statiques du refuge, affichées dans l'onglet "Le refuge".
struct Shelter {
    var name: String
    var logoImageName: String
    var shortPresentation: String
    var mission: String
    var team: String
    var openingHours: String
    var phone: String
    var email: String
    var address: String
}

extension Shelter {
    // Les données du refuge présenté par l'application.
    static let current = Shelter(
        name: "Refuge Espoir",
        logoImageName: "ShelterLogo",
        shortPresentation: "Depuis 2010, le Refuge Espoir accueille, soigne et trouve des familles aimantes pour les animaux abandonnés ou perdus de la région.",
        mission: "Notre mission est d'offrir un abri sûr à chaque animal dans le besoin, de veiller à son bien-être physique et émotionnel, et de favoriser des adoptions responsables et durables.",
        team: "Une équipe de 8 bénévoles passionnés et 3 soigneurs professionnels s'occupe des animaux tous les jours de l'année, épaulée par notre vétérinaire attitrée, Dre Tremblay.",
        openingHours: "Lundi au vendredi : 9h00 – 17h00\nSamedi : 10h00 – 15h00\nDimanche : Fermé",
        phone: "418 555-0192",
        email: "info@refuge-espoir.org",
        address: "123 rue des Érables, Québec, QC G1V 2M2"
    )
}
