import SwiftUI


struct ViewListCities: View {
    @EnvironmentObject var list: ListaViewModel
    @State private var cityName: String = ""
    @Binding var name: String  // Asegúrate de que name sea un Binding


    var body: some View {
        NavigationStack {
            VStack {

                NavigationLink(destination:
                    VStack {
                        Form {
                            Section(header: Text("Nombre Ciudad")) {
                                TextField("Nombre Ciudad", text: $cityName)
                            }
                            Button(action: {
                                list.addToString(cityName)
                                cityName = ""  // Limpia el campo de texto
                            }, label: {
                                Text("Añadir Ciudad")
                            })
                        }
                        .frame(maxWidth: .infinity, maxHeight: 170)
                        
                        List {
                            // Aquí cambiamos para acceder al array de ciudades
                            ForEach(list.listOfCities.city, id: \.self) { index in
                                Text(index)
                                    .onTapGesture {
                                        name = index // Cambia el valor de name al de la ciudad seleccionada
                                        print("Tapped on \(index)") // Para depuración
                                    }
                            }
                            .onDelete(perform: deleteCity)
                        }
                    }
                ) {
                    Text("Lista de ciudades")
                        .frame(width: 100, height: 50)
                        .foregroundStyle(.black)
                        .background(.green)
                        .opacity(0.85)
                        .cornerRadius(10)
                }
            }
        }
    }


    func deleteCity(at offsets: IndexSet) {
        for index in offsets {
            let cityToDelete = list.listOfCities.city[index]
            list.removeFromString(cityToDelete)
        }
    }
}


