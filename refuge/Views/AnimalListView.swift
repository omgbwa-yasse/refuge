//
//  AnimalListView.swift
//  refuge
//

import SwiftUI

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
                AnimalDetailView(animal: $appModel.animals[index])
            }
        }
    }
}

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
