//  ContentView.swift
//  Wheater APP
//  Created by Jianji Zhong Huang on 5/10/24.
import SwiftUI

struct ContentView: View {
    @StateObject var modelView: ModelView = ModelView()
    @State var city: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
                
                VStack {
                    TextField("Enter City", text: $city)
                        .padding()
                        .background(.white)
                        .cornerRadius(10)
                        .padding()
                    Text("\(modelView.model.city) 📍")
                        .font(.system(size: 40, weight: .bold))
                   
                    Temperaturas(modelView: modelView)
                    
                    TemperaturasMaxYMin(modelView: modelView)
                    
                    HumidityAndThermSensation(modelView: modelView)

                    Spacer()

                    button
                    
                    Spacer()

                   ViewListCities(name: $city)
                    
                }.onAppear(){
                    Task{
                        await modelView.getWheater(city: city)
                    }
                }
            }
        }
    }
    
    var button: some View {
        Button(action: {
            Task{
                await modelView.getWheater(city: city)
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

