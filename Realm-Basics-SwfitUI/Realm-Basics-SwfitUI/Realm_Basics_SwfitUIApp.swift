//
//  Realm_Basics_SwfitUIApp.swift
//  Realm-Basics-SwfitUI
//
//  Created by Harsh Yadav on 24/12/22.
//

import SwiftUI

@main
struct Realm_Basics_SwfitUIApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .onAppear{
                    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!)
                }
        }
    }
}
