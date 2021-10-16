//
//  AppDelegate.swift
//  donAIte
//
//  Created by Аня on 16.10.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let defaults = UserDefaults.standard
        if defaults.value(forKey: "Local")==nil {
            defaults.set(50, forKey: "Local")
        }
        if defaults.value(forKey: "International")==nil {
            defaults.set(50, forKey: "International")
        }
        if defaults.value(forKey: "Medicine")==nil {
            defaults.set(50, forKey: "Medicine")
        }
        if defaults.value(forKey: "Environment")==nil {
            defaults.set(50, forKey: "Environment")
        }
        if defaults.value(forKey: "Human rights")==nil {
            defaults.set(50, forKey: "Human rights")
        }
        if defaults.value(forKey: "Animal rights")==nil {
            defaults.set(50, forKey: "Animal rights")
        }
        if defaults.value(forKey: "Refugees")==nil {
            defaults.set(50, forKey: "Local")
        }
        if defaults.value(forKey: "Science")==nil {
            defaults.set(50, forKey: "Science")
        }
        if defaults.value(forKey: "Art")==nil {
            defaults.set(50, forKey: "Art")
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

