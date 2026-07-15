//
//  AnimalDetailView.swift
//  refuge
//

import SwiftUI

// Scène de détails d'un animal : image interactive (4 gestes), informations,
// jauge de bien-être et section explicative des gestes disponibles.
// @Binding (et non une simple valeur) : les modifications faites ici écrivent
// directement dans appModel.animals, donc elles sont conservées au retour à la liste.
struct AnimalDetailView: View {
    @Binding var animal: Animal

    @State private var dragOffset: CGSize = .zero
    @State private var currentMagnification: CGFloat = 1.0
    @State private var interactionMessage: String = "Touchez, appuyez longuement, glissez ou pincez l'image pour interagir avec l'animal."

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                animalImage

                infoSection

                wellbeingSection

                interactionMessageView

                gestureInfoSection
            }
            .padding()
        }
        .navigationTitle(animal.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Image et gestes

    // Les 4 gestes demandés sont tous appliqués directement sur l'image :
    // - Tap        : augmente le bien-être (max 10)
    // - LongPress  : bascule le statut d'adoption
    // - Drag       : déplace l'image, qui revient à sa place une fois le geste terminé
    // - Magnification : agrandit/réduit l'image, qui reprend sa taille une fois le geste terminé
    // Drag et Magnification doivent pouvoir se produire "en même temps" du point de
    // vue de SwiftUI, d'où l'utilisation de SimultaneousGesture pour les combiner.
    private var animalImage: some View {
        Image(animal.imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
            .frame(height: 260)
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .shadow(radius: 6)
            .offset(dragOffset) // position temporaire pendant le Drag
            .scaleEffect(currentMagnification) // taille temporaire pendant le Magnification
            .onTapGesture {
                increaseWellbeing()
            }
            .onLongPressGesture(minimumDuration: 0.6) {
                toggleAdoptionStatus()
            }
            .gesture(
                SimultaneousGesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffset = value.translation
                        }
                        .onEnded { _ in
                            // Fin du geste : l'image retourne à sa position initiale.
                            withAnimation(.spring()) {
                                dragOffset = .zero
                            }
                            interactionMessage = "L'image a été déplacée, puis est revenue à sa position initiale."
                        },
                    MagnificationGesture()
                        .onChanged { value in
                            currentMagnification = value
                        }
                        .onEnded { _ in
                            // Fin du geste : l'image reprend sa taille initiale.
                            withAnimation(.spring()) {
                                currentMagnification = 1.0
                            }
                            interactionMessage = "L'image a été redimensionnée, puis a repris sa taille initiale."
                        }
                )
            )
            .animation(.interactiveSpring(), value: dragOffset)
    }

    // MARK: - Info

    private var infoSection: some View {
        VStack(spacing: 6) {
            Text(animal.name)
                .font(.largeTitle.bold())
            Text("\(animal.species) · \(animal.ageDescription)")
                .font(.title3)
                .foregroundStyle(.secondary)

            Label(animal.adoptionStatus.rawValue, systemImage: animal.adoptionStatus.symbolName)
                .font(.subheadline.bold())
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    Capsule().fill(animal.adoptionStatus == .available ? Color.green.opacity(0.15) : Color.orange.opacity(0.15))
                )
                .foregroundStyle(animal.adoptionStatus == .available ? .green : .orange)
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Bien-être

    // Affiche le niveau de bien-être (jauge visuelle sur 10) et le message
    // correspondant (voir Animal.wellbeingMessage).
    private var wellbeingSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Label("Niveau de bien-être", systemImage: "heart.text.square.fill")
                    .font(.headline)
                Spacer()
                Text("\(animal.wellbeing)/10")
                    .font(.headline.monospacedDigit())
            }

            WellbeingGaugeView(level: animal.wellbeing)

            Text(animal.wellbeingMessage)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }

    // Message qui informe l'utilisateur du résultat de la dernière action effectuée.
    private var interactionMessageView: some View {
        Text(interactionMessage)
            .font(.callout.weight(.medium))
            .multilineTextAlignment(.center)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.accentColor.opacity(0.12))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .animation(.easeInOut, value: interactionMessage)
    }

    // Section "Gestes disponibles" : rappelle les 4 gestes et leur effet.
    private var gestureInfoSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Gestes disponibles", systemImage: "hand.draw.fill")
                .font(.headline)

            GestureInfoRow(icon: "hand.tap.fill", title: "Toucher (Tap)", description: "Augmente le niveau de bien-être de l'animal.")
            GestureInfoRow(icon: "hand.point.up.left.and.text.fill", title: "Appui long (Long Press)", description: "Change le statut d'adoption de l'animal.")
            GestureInfoRow(icon: "arrow.up.and.down.and.arrow.left.and.right", title: "Glisser (Drag)", description: "Déplace temporairement l'image, qui revient ensuite à sa position initiale.")
            GestureInfoRow(icon: "arrow.up.left.and.arrow.down.right.circle.fill", title: "Pincer (Magnification)", description: "Agrandit ou réduit temporairement l'image, qui reprend ensuite sa taille initiale.")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }

    // MARK: - Actions déclenchées par les gestes

    // TapGesture : augmente le bien-être de 1, jusqu'à un maximum de 10.
    private func increaseWellbeing() {
        guard animal.wellbeing < 10 else {
            interactionMessage = "\(animal.name) est déjà au maximum de bien-être (10/10) !"
            return
        }
        withAnimation {
            animal.wellbeing += 1
        }
        interactionMessage = "Niveau de bien-être augmenté à \(animal.wellbeing)/10 !"
    }

    // LongPressGesture : alterne le statut entre "Disponible pour adoption" et "Adopté".
    private func toggleAdoptionStatus() {
        withAnimation {
            animal.adoptionStatus = animal.adoptionStatus == .available ? .adopted : .available
        }
        interactionMessage = "Statut changé : \(animal.adoptionStatus.rawValue)."
    }
}

// Une ligne de la section "Gestes disponibles" (icône + titre + description).
private struct GestureInfoRow: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(.tint)
                .frame(width: 28)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline.bold())
                Text(description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

// Représentation visuelle du bien-être : 10 capsules, dont "level" sont colorées.
private struct WellbeingGaugeView: View {
    let level: Int

    var body: some View {
        HStack(spacing: 4) {
            ForEach(1...10, id: \.self) { index in
                Capsule()
                    .fill(index <= level ? color(for: level) : Color(.systemGray5))
                    .frame(height: 14)
            }
        }
    }

    // Couleur de la jauge selon le niveau : rouge (faible), orange (moyen), vert (bon).
    private func color(for level: Int) -> Color {
        switch level {
        case 0...3: return .red
        case 4...6: return .orange
        default: return .green
        }
    }
}

#Preview {
    NavigationStack {
        AnimalDetailView(animal: .constant(Animal.sampleAnimals[0]))
    }
}
