//  Pruebas.swift
//  Wheater APP
//  Created by Jianji Zhong Huang on 8/10/24.
// Fichero para probar cosas de SWIFTUI, se puede borrar

import SwiftUI

struct NavView: View {
    @State var showDropdown: Bool = false
    @State var ciudad: String = ""
    var body: some View {
        NavigationStack{
            ZStack{
                
                LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
                
                Desplagable(showDropdown: $showDropdown)
                
                if !showDropdown{
                    VStack{
                        ToolBarr(showDropdown: $showDropdown)
                            .padding(.horizontal, 10)
                        
                        Text("Valencia 📍")
                            .font(.system(size: 40, weight: .bold))
                        TemperaturasPrueba()
                        
                        TemperaturasMaxYMinPruebas()
                        
                        HumidityAndThermSensationPruebas()
                        
                        Spacer()
                        
                        Button(action: {
                        }, label: {
                            Text("Buscar")
                                .frame(width: 100, height: 50)
                                .foregroundStyle(.black)
                                .background(.green)
                                .opacity(0.85)
                                .cornerRadius(10)
                        })
                        Spacer()
                    }
                }
                
                
            }
        }
    }
}

struct ToolBarr: View {
    @State private var ciudad: String = ""
    @State private var showTextField: Bool = false // Controla si el TextField se muestra
    @Binding var showDropdown: Bool
    @State var showSearch: [String] = ["Valencia", "Madrid", "Barcelona"]

    var body: some View {
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

            if showTextField {
                // Muestra el TextField cuando la variable showTextField es true
                TextField("Introduce ciudad", text: $ciudad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: .infinity, maxHeight: 50)
            } else {
                // Muestra un rectángulo cuando no se muestra el TextField
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .opacity(0.0)
            }

            Button(action: {
                // Cambia el estado de showTextField al pulsar la lupa
                withAnimation {
                    showTextField.toggle()
                }
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.black)
                    .font(.system(size: 23, weight: .medium))
            }
        }
        .padding()
        
        // Vista desplegable que aparece cuando `showDropdown` es `true`
        
    }
}

struct Desplagable: View {
    @State var ciudad: String = ""
    @Binding var showDropdown: Bool
    @State var showSearch: [String] = ["Valencia", "Madrid", "Barcelona"]
    
    var body: some View {
        VStack{
            
            if showDropdown {
                /*Ponerlo en un struct separado dentro del ZStack de la vista principal porque se debe de mostrar por encima*/
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
                                TextField("Nombre Ciudad", text: $ciudad)
                            }
    
                            Button(action: {
                            }, label: {
                                Text("Añadir Ciudad")
                            })
                            
                            List {
                                ForEach(showSearch, id: \.self) { index in
                                    Text(index)
                                        .onTapGesture {
                                            //name = index
                                            // Cambia el valor de name al de la ciudad seleccionada
                                        }
                                }
                                //.onDelete(perform: deleteCity)
                            }
                        }.padding(.top, 10)
                    }
 
                }.background(.white)
                    .shadow(radius: 5)
                    .transition(.move(edge: .leading)) // Efecto de transición desde arriba
                    .ignoresSafeArea()
               
                
            }
        }
    }
}

struct TemperaturasPrueba: View {
    
    var body: some View{
        VStack{
            Text("29ºC")
                .font(.system(size: 70, weight: .medium))
            Image(systemName:"cloud.sun.rain")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
        }
    }
}

struct HumidityAndThermSensationPruebas: View {
    var body: some View {
        VStack{
            Text("Sensacion Termica: 25ºC")
                .font(.system(size: 20, weight: .medium))
            
            HStack{
                Text("Humedad: 40% 💧")
                    .font(.system(size: 20, weight: .medium))
            }
        }
    }
}

struct TemperaturasMaxYMinPruebas: View {
    var body: some View {
        HStack{
            Text("Max: 32ºC")
                .font(.system(size: 20, weight: .medium))
            Image(systemName:"thermometer.high")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 35)
                .foregroundStyle(.red).opacity(0.6)
            Text("Min: 18ºC")
                .font(.system(size: 20, weight: .medium))
            Image(systemName:"thermometer.low")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 35)
                .foregroundStyle(.blue).opacity(0.6)
        }
    }
}

#Preview {
    NavView()
}
