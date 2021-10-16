import Foundation

public struct User {
    public var preferences = ["Local":0,
                              "International":0,
                              "Medicine":0,
                              "Environment":0,
                              "Human rights":0,
                              "Animal rights":0,
                              "Refugees":0,
                              "Science":0,
                              "Art":0]
    
    init() {
        let defaults = UserDefaults.standard
        preferences["Local"] = defaults.integer(forKey: "Local")
        preferences["International"] = defaults.integer(forKey: "International")
        preferences["Medicine"] = defaults.integer(forKey: "Medicine")
        preferences["Environment"] = defaults.integer(forKey: "Environment")
        preferences["Human rights"] = defaults.integer(forKey: "Human rights")
        preferences["Animal rights"] = defaults.integer(forKey: "Animal rights")
        preferences["Refugees"] = defaults.integer(forKey: "Refugees")
        preferences["Science"] = defaults.integer(forKey: "Science")
        preferences["Art"] = defaults.integer(forKey: "Art")

    }
}
