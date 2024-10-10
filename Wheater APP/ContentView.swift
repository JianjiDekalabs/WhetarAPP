//  ContentView.swift
//  Wheater APP
//  Created by Jianji Zhong Huang on 5/10/24.
import SwiftUI

struct ContentView: View {
    @StateObject var modelView: ModelView = ModelView()
    @State var city: String = ""
    @State var showDropdown: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
                
                if !showDropdown {
                    VStack {
                        ToolBar(city: $city, showDropdown: $showDropdown)
                        
                        Text("\(modelView.model.city) 📍")
                            .font(.system(size: 40, weight: .bold))
                        
                        Temperaturas(modelView: modelView)
                        
                        TemperaturasMaxYMin(modelView: modelView)
                        
                        HumidityAndThermSensation(modelView: modelView)
                        
                        Spacer()
                        
                        button //Boton de buscar
                        
                        Spacer()
                        
                    }.onAppear(){
                        Task{
                            await modelView.getWheater(city: city)
                        }
                    }
                }
                ViewListCities(name: $city, showDropdown: $showDropdown, modelView: modelView)
                
            }
        }
    }
    
    var button: some View {
        Button(action: {
            Task{
                await modelView.getWheater(city: city)
                city = "" //Restablece el texfield del buscador
            }
        }, label: {
            Text("Buscar")
                .frame(width: 100, height: 50)
                .foregroundStyle(.black)
                .background(.green)
                .opacity(0.85)
                .cornerRadius(10)
        })
    }
    
}

struct ToolBar: View {
    @Binding var city: String
    @State private var showTextField: Bool = false // Controla si el TextField se muestra
    @Binding var showDropdown: Bool
    
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
                TextField("Introduce ciudad", text: $city)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .onAppear {
                        city = "" //Restablece el texfield del buscador
                    }
            } else {
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
    }
}

struct Temperaturas: View {
    @StateObject var modelView: ModelView
    
    var body: some View{
        VStack{
            Text("\(String(format: "%.1f", modelView.model.main.temp).prefix(4))ºC")
                .font(.system(size: 70, weight: .medium))
            Image(systemName:"cloud.sun.rain")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            //Sustituir por el icono que proporciona la API
        }
    }
}

struct HumidityAndThermSensation: View {
    @StateObject var modelView: ModelView
    var body: some View {
        VStack{
            Text("Sensacion Termica: \(String(format: "%.1f", modelView.model.main.feelsLike).prefix(4))ºC")
                .font(.system(size: 20, weight: .medium))
            
            HStack{
                Text("Humedad \(String(format: "%2f", modelView.model.main.humidity).prefix(2))% 💧")
                    .font(.system(size: 20, weight: .medium))
            }
        }
    }
}

struct TemperaturasMaxYMin: View {
    @StateObject var modelView: ModelView
    var body: some View {
        HStack{
            Text("Max: \(String(format: "%.1f", modelView.model.main.tempMax).prefix(4))ºC")
                .font(.system(size: 20, weight: .medium))
            Image(systemName:"thermometer.high")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 35)
                .foregroundStyle(.red).opacity(0.6)
            Text("Min: \(String(format: "%.1f", modelView.model.main.tempMin).prefix(4))ºC")
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
    ContentView()
        .environmentObject(ListaViewModel())
}

