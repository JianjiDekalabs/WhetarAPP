import SwiftUI
import Foundation

class ListaViewModel: ObservableObject {
    let name: String
    @Published var listOfCities: ListCities = ListCities(city: []) {
        didSet {
            autoSave()
            
        }
    }

    let autoSaveURL: URL = URL.documentsDirectory.appendingPathComponent("autoSave.json")
    
    func autoSave(){
        save(to: autoSaveURL)
    }
    
    func save(to url: URL) {
        do {
            let data = try listOfCities.json() // Codifica el array
            try data.write(to: url) // Escribe los datos en el archivo
        } catch {
            print("Error guardando datos: \(error)") // Maneja el error aquí
        }
    }
    
    init() {
        self.name = "Default Name" // Asignar valor predeterminado a `name`
        
        if let data = try? Data(contentsOf: autoSaveURL),
           let autoSaveList = try? ListCities(json: data) {
            listOfCities = autoSaveList
        } else {
            self.listOfCities = ListCities(city: ["Madrid", "Valencia", "Limerick"])
        }
    }

    func addToString(_ city: String) {
        self.listOfCities.city.append(city)
        save(to: autoSaveURL)
    }
    
    func removeFromString(_ city: String) {
        self.listOfCities.city.removeAll(where: { $0 == city })
    }
}
