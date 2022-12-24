//
//  ItemModel.swift
//  Realm-Basics-SwfitUI
//
//  Created by Harsh Yadav on 24/12/22.
//

import Foundation
import RealmSwift

final class ItemModel:Object,ObjectKeyIdentifiable{
    
    @Persisted(primaryKey: true) var _id:ObjectId
    @Persisted var name:String
    @Persisted var isFav:Bool = false
    
    
    @Persisted(originProperty: "items") var groupModel:LinkingObjects<GroupModel>
    
    convenience init(name:String){
        self.init()
        self.name = name
    }
}
