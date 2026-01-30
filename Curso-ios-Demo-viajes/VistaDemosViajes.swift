//
//  ContentView.swift
//  Curso-ios-Demo-viajes
//
//  Created by Equipo 8 on 29/1/26.
//

import SwiftUI

struct VistaDemosViajes: View {
    @State private var nombreUsuario: String = ""

    @State private var destinos: [Destino] = [
        Destino(
            nombre: "París",
            icono: "building.columns.fill",
            descripcion: "Amor y luz",
            color: .blue
        ),
        Destino(
            nombre: "Roma",
            icono: "globe.europe.africa.fill",
            descripcion: "Historia y tradición.",
            color: .orange,
            esFavorito: true,
            puntuacion: 3
        ),
        Destino(
            nombre: "Tokio",
            icono: "tram.fill",
            descripcion: "Neones y ramen",
            color: .red,
            esFavorito: true,
            puntuacion: 3
        ),
    ]
    var body: some View {
        TabView {
            VistaListaDestinos(
                destinos: $destinos,
                nombreUsuario: $nombreUsuario
            )
            .tabItem {
                Label("Explorar", systemImage: "map")
            }
            NavigationStack {
                VistaPerfilUsuario(nombreUsuario: $nombreUsuario)
            }
            .tabItem {
                Label("Mi perfil", systemImage: "person.circle")
            }
        }
    }
}
struct VistaListaDestinos: View {
    @Binding var destinos: [Destino]
    @Binding var nombreUsuario: String

    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink(
                        destination: VistaPerfilUsuario(
                            nombreUsuario: $nombreUsuario
                        )
                    ) {
                        HStack {
                            (Text("Hola, ")
                                .foregroundStyle(.gray)
                                + Text(
                                    nombreUsuario.isEmpty
                                        ? "Viajero/a" : nombreUsuario
                                )
                                .foregroundStyle(.primary)
                                .bold())
                                .font(.title2)

                            Spacer()

                            Image(systemName: "pencil.circle.fill")
                                .foregroundStyle(.blue)
                        }
                        .padding(.vertical, 5)
                    }
                }
                .listRowBackground(Color.clear)  // quitamos el fondo de la celda
                .listRowSeparator(.hidden)

                //Sección destinos
                Section("Tus destinos") {
                    ForEach($destinos) { $destino in
                        NavigationLink(
                            destination: VistaDetalleDestino(destino: $destino)
                        ) {
                            HStack(spacing: 15) {
                                ZStack {
                                    Circle()
                                        .fill(destino.color)
                                        .frame(width: 50)
                                    Image(systemName: destino.icono)
                                        .foregroundStyle(.white)
                                }
                                VStack(alignment: .leading) {
                                    Text(destino.nombre)
                                        .font(.headline)

                                    if destino.puntuacion > 0 {
                                        HStack(spacing: 2) {
                                            ForEach(
                                                0..<destino.puntuacion,
                                                id: \.self
                                            ) { _ in
                                                Image(systemName: "star.fill")
                                                    .foregroundStyle(.yellow)
                                                    .font(.caption2)
                                            }
                                        }
                                    } else {
                                        Text("Sin valorar")
                                            .font(.caption2)
                                            .foregroundStyle(.gray.opacity(0.5))
                                    }
                                }
                                Spacer()

                                if destino.esFavorito {
                                    Image(systemName: "heart.fill")
                                        .foregroundStyle(.red)
                                }
                            }

                        }

                    }
                }
            }
            .navigationTitle("Destinos")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

#Preview {
    VistaDemosViajes()
}
