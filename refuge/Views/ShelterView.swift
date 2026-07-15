//
//  ShelterView.swift
//  refuge
//

import SwiftUI

// Page d'accueil de l'application (onglet "Le refuge") : présente l'établissement
// et permet de rebondir vers l'onglet "Animaux" en touchant la section dédiée.
struct ShelterView: View {
    @Environment(AppModel.self) private var appModel

    private var shelter: Shelter { appModel.shelter }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    header

                    SectionCard(title: "Présentation", systemImage: "text.alignleft") {
                        Text(shelter.shortPresentation)
                    }

                    animalsAccueillisSection

                    SectionCard(title: "Notre mission", systemImage: "heart.fill") {
                        Text(shelter.mission)
                    }

                    SectionCard(title: "Notre équipe", systemImage: "person.3.fill") {
                        Text(shelter.team)
                    }

                    SectionCard(title: "Heures d'ouverture", systemImage: "clock.fill") {
                        Text(shelter.openingHours)
                    }

                    SectionCard(title: "Nous joindre", systemImage: "phone.circle.fill") {
                        VStack(alignment: .leading, spacing: 8) {
                            Label(shelter.phone, systemImage: "phone.fill")
                            Label(shelter.email, systemImage: "envelope.fill")
                            Label(shelter.address, systemImage: "mappin.and.ellipse")
                        }
                    }

                    credits
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }

    private var header: some View {
        VStack(spacing: 12) {
            Image(shelter.logoImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 140, height: 140)
                .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                .shadow(radius: 4)

            Text(shelter.name)
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }

    // Section interactive : toucher cette carte bascule automatiquement l'application
    // sur l'onglet "Animaux" via appModel.openAnimalsTab().
    private var animalsAccueillisSection: some View {
        Button {
            withAnimation {
                appModel.openAnimalsTab()
            }
        } label: {
            SectionCard(title: "Animaux accueillis", systemImage: "pawprint.fill") {
                HStack {
                    Text("\(appModel.animals.count) animaux vous attendent actuellement au refuge. Touchez ici pour les découvrir.")
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.secondary)
                }
            }
        }
        .buttonStyle(.plain)
    }

    // Crédit de l'équipe ayant réalisé l'application (noms en gras).
    private var credits: some View {
        (
            Text("Réalisé par : ")
            + Text("Ester Nduwimana, Tinhinane Tahakourt et Omgbwa Yasse").bold()
        )
        .font(.title3)
        .foregroundStyle(.secondary)
        .frame(maxWidth: .infinity, alignment: .center)
        .multilineTextAlignment(.center)
    }
}

// Carte réutilisable pour présenter une section du refuge avec un titre et une icône.
private struct SectionCard<Content: View>: View {
    let title: String
    let systemImage: String
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(title, systemImage: systemImage)
                .font(.headline)
                .foregroundStyle(.tint)
            content
                .font(.body)
                .foregroundStyle(.primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

#Preview {
    ShelterView()
        .environment(AppModel())
}
