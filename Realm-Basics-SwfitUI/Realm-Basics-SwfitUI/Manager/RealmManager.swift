//
//  RealmManager.swift
//  Realm-Basics-SwfitUI
//
//  Created by Harsh Yadav on 24/12/22.
//

import Foundation
import RealmSwift
class RealmManager{
    static let shared:RealmManager = RealmManager()
    var realm:Realm?
    init(){
        self.setup()
    }
    
    func setup(){
        do{
            self.realm = try Realm()
        }catch{
            print("Error while opening Realm DB",error)
        }
    }
}
