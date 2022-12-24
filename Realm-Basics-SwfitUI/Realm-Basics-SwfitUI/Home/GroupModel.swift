//
//  GroupModel.swift
//  Realm-Basics-SwfitUI
//
//  Created by Harsh Yadav on 24/12/22.
//

import Foundation
import RealmSwift

final class GroupModel:Object,ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var _id:ObjectId
    
    @Persisted var groupTitle:String
    @Persisted var items = List<ItemModel>() //Array of ItemModel
    
    convenience init(groupTitle:String){
        self.init()
        self.groupTitle = groupTitle
    }
}

