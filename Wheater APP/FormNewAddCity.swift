//
//  FormNewAddCity.swift
//  Wheater APP
//
//  Created by Jianji Zhong Huang on 8/10/24.
//
import SwiftUI
//Borrar
struct FormNewAddCity: View {
    @State var cityName: String = ""
    var body: some View {
        Form {
            Section(header: Text("Nombre Ciudad")) {
                TextField("Nombre Ciudad", text: $cityName)
            }
            Button(action: {}, label: {
                Text("Añadir Ciudad")
                }
                
            )
        }
    }
}

#Preview {
    FormNewAddCity()
}
