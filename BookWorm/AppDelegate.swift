//
//  AppDelegate.swift
//  BookWorm
//
//  Created by 정경우 on 2023/07/31.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let config = Realm.Configuration(schemaVersion: 0) { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 { } //translator 칼럼 추가
            if oldSchemaVersion < 2 { } //translator 칼럼 제거
            if oldSchemaVersion < 3 { } //translator 칼럼 추가
            if oldSchemaVersion < 4 {

                migration.renameProperty(onType: BookTable.className(), from: "translator", to: "trans")

            } //translator -> trans로 칼럼 이름 변경
            
            if oldSchemaVersion < 5 {
                
                migration.enumerateObjects(ofType: BookTable.className()) { oldObject, newObject in
                    guard let new = newObject else { return }
                    guard let old = oldObject else { return }
                    
                    new["trans"] = "  \(old["title"]), \(old["authors"]) "
                }
                
            } //칼럼 내용 합치기(title + authors)
            
            
            
        }
      
        Realm.Configuration.defaultConfiguration = config

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

