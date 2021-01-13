//
//  AppDelegate.swift
//  todoApp
//
//  Created by Marmago on 25/11/2020.
//

import UIKit
import RealmSwift


@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        do{
            _ = try Realm()
        }catch{
            print("Error initialising new realm: \(error)")
        }
        
       
        return true
    }
    func applicationWillTerminate(_ application: UIApplication) {

    }
}

