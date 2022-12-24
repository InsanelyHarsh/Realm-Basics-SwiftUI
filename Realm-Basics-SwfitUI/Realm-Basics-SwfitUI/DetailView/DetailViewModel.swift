//
//  DetailViewModel.swift
//  Realm-Basics-SwfitUI
//
//  Created by Harsh Yadav on 24/12/22.
//

import Foundation
import RealmSwift


class DetailViewModel:ObservableObject{
    var realm = RealmManager.shared.realm
    @Published var itemTitle:String = ""
    @Published var itemsArray:[ItemModel] = []
    var group:GroupModel?

    func fetchItems(of group:GroupModel){
        
        guard let dbRef = realm else { return }
        let result = dbRef.freeze().object(ofType: GroupModel.self, forPrimaryKey: group._id)
        self.itemsArray = result!.items.map{$0}
        self.group = group
    }
    
    func addNewItem(to group:GroupModel){
        guard let dbRef = realm else { return }
        let liveGroup = group.thaw()!
        try! dbRef.write {
            liveGroup.items.append(ItemModel(name: itemTitle))
        }
        self.itemTitle = ""
    }
    
    
    func remove(indexSet:IndexSet) {
        guard let index = indexSet.first else { return }
        let selectedGroup = self.itemsArray[index]
        delete(selectedGroup: selectedGroup)
    }
    
    func delete(selectedGroup:ItemModel){
        let liveGroup = selectedGroup.thaw()!      //We cannot delete Frozen Object
        
        if(!liveGroup.isFrozen){
            try! self.realm!.write({
                self.realm!.delete(liveGroup)
            })
        }
        self.fetchItems(of: group!)
    }
}
