//  ModelView.swift
//  Wheater APP
//  Created by Jianji Zhong Huang on 6/10/24.

import SwiftUI

final class ModelView: ObservableObject {
    
    @Published var model: Model = .empty
    
    let modelWheater: WheaterModelMapper = WheaterModelMapper()
    
    func getWheater(city: String) async{
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=YOURAPINUMBERGOESHERE&units=metric&lang=es"
        )!
        
        do{
            async let (data, _) = try await URLSession.shared.data(from: url)
            let dataModel = try await JSONDecoder().decode(Model.self, from: data)
            
            DispatchQueue.main.async {
                self.model = self.modelWheater.mapDataModel(dataModel: dataModel)
            }
            
        } catch let error {
            print("Error fetching weather data: \(error.localizedDescription)")
        }
    }
}
