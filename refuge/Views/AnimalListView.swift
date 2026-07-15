//
//  AnimalListView.swift
//  refuge
//

import SwiftUI

// Liste des animaux du refuge (onglet "Animaux"). La navigation se fait par
// index (NavigationLink(value: index)) plutôt que par valeur copiée, afin de
// pouvoir passer un Binding vers l'animal exact dans appModel.animals :
// c'est ce qui permet aux modifications faites dans AnimalDetailView (bien-être,
// statut d'adoption) d'être conservées quand on revient à la liste.
struct AnimalListView: View {
    @Environment(AppModel.self) private var appModel
    @State private var path: [Int] = []

    var body: some View {
        @Bindable var appModel = appModel

        NavigationStack(path: $path) {
            List {
                ForEach(appModel.animals.indices, id: \.self) { index in
                    NavigationLink(value: index) {
                        AnimalRow(animal: appModel.animals[index])
                    }
                }
            }
            .navigationTitle("Animaux")
            .listStyle(.insetGrouped)
            .navigationDestination(for: Int.self) { index in
                // Binding direct vers l'élément du tableau partagé : toute
                // modification dans la scène de détails est donc persistée.
                AnimalDetailView(animal: $appModel.animals[index])
            }
        }
    }
}

// Ligne de la liste : image, nom, espèce et statut d'adoption de l'animal.
private struct AnimalRow: View {
    let animal: Animal

    var body: some View {
        HStack(spacing: 16) {
            Image(animal.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 64, height: 64)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            VStack(alignment: .leading, spacing: 4) {
                Text(animal.name)
                    .font(.headline)
                Text(animal.species)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text(animal.adoptionStatus.rawValue)
                .font(.caption.bold())
                .multilineTextAlignment(.trailing)
                .foregroundStyle(animal.adoptionStatus == .available ? .green : .orange)
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    AnimalListView()
        .environment(AppModel())
}
