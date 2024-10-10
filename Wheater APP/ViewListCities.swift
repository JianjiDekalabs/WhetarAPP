import SwiftUI

struct ViewListCities: View {
    @EnvironmentObject var list: ListaViewModel
    @State private var cityName: String = ""
    @Binding var name: String
    @Binding var showDropdown: Bool
    
    @StateObject var modelView: ModelView
    @State private var cityWeatherData: [String: Model] = [:]
    // Diccionario para almacenar el clima de cada ciudad
    
    var body: some View {
        NavigationStack {
            VStack {
                if showDropdown {
                    NavigationStack {
                        VStack {
                            Rectangle()
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .opacity(0)
                            HStack {
                                Button(action: {
                                    withAnimation {
                                        showDropdown.toggle()
                                    }
                                }) {
                                    Image(systemName: "line.3.horizontal")
                                        .foregroundStyle(.black)
                                        .font(.system(size: 25, weight: .medium))
                                }
                                Rectangle()
                                    .frame(maxWidth: .infinity, maxHeight: 30)
                                    .opacity(0)
                                
                            }.padding(.horizontal, 10)
                            
                            Form {
                                Section(header: Text("Nombre Ciudad")) {
                                    TextField("Nombre Ciudad", text: $cityName)
                                }
                                
                                Button(action: {
                                    list.addToString(cityName)
                                }, label: {
                                    Text("Añadir Ciudad")
                                })
                                
                                List {
                                    ForEach(list.listOfCities.city, id: \.self) { city in
                                        HStack {
                                            Text(city)
                                            Spacer()
                                            if let weather = cityWeatherData[city] {
                                                Text("\(String(format: "%.1f", weather.main.temp))ºC")
                                                    .foregroundColor(.gray)
                                            } else {
                                                Text("Cargando...")
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                        .onAppear {
                                            Task {
                                                if cityWeatherData[city] == nil {
                                                    await loadWeather(city)
                                                }
                                            }
                                        }
                                        .onTapGesture {
                                            name = city
                                            // Cambia el valor de name al de la ciudad seleccionada
                                            withAnimation {
                                                showDropdown.toggle()
                                            }
                                            
                                        }
                                    }
                                    .onDelete(perform: deleteCity)
                                }
                                .padding(.top, 10)
                            }
                        }
                    }
                    .background(.white)
                    .shadow(radius: 5)
                    .transition(.move(edge: .leading)) // Efecto de transición desde la izquierda
                    .ignoresSafeArea()
                }
            }
        }
    }
    
    // Función para cargar el clima de una ciudad y almacenarlo en el diccionario
    private func loadWeather(_ city: String) async {
        await modelView.getWheater(city: city)
        DispatchQueue.main.async {
            self.cityWeatherData[city] = modelView.model // Almacena el clima en el diccionario
        }
    }
    
    func deleteCity(at offsets: IndexSet) {
        for index in offsets {
            let cityToDelete = list.listOfCities.city[index]
            list.removeFromString(cityToDelete)
            cityWeatherData[cityToDelete] = nil // Elimina el clima de la ciudad del diccionario
        }
    }
}
