//
//  AppDelegate.swift
//  Todoey
//
//  Created by sophea chea on 5/12/20.
//

import UIKit
import CoreData
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        print("Did finish Launching with options")
        
        //MARK: RealmSwift
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)    // Print realm data path
        
        
        do{
            _ = try Realm()
        }catch {
            print("Error initialising new realm, \(error)")
        }
        
        return true
    }

}

