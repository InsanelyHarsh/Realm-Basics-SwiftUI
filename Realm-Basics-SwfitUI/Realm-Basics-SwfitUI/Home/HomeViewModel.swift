//
//  HomeViewModel.swift
//  Realm-Basics-SwfitUI
//
//  Created by Harsh Yadav on 24/12/22.
//

import Foundation
import RealmSwift


class HomeViewModel:ObservableObject{
    var realm = RealmManager.shared.realm
    @Published var newGroupTitle:String = "Default Group Title"
    @Published var updateTitle:String = ""
    @Published var groupsArray:[GroupModel] = []

    private var countriesToken: NotificationToken?
    
    init() {
//        initializeSchema(name: name)
        setupObserver()
    }
    
    func fetchData(){

        guard let dbRef = realm else { return }
        let result = dbRef.freeze().objects(GroupModel.self) //frozen Result

        self.groupsArray = result.compactMap({ (group)->GroupModel? in //mapping to array
            return group
        })
    }
    
    func setupObserver() {
        guard let realm = realm else { return }
        
        let observedGroups = realm.objects(GroupModel.self)
        
        countriesToken = observedGroups.observe({ [weak self] _ in

            self?.groupsArray = observedGroups.map{ $0.freeze()}
        })
    }
    
    func initializeSchema(name: String) {
        let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let realmFileUrl = docDir.appendingPathComponent("\(name).realm")
        let config = Realm.Configuration(fileURL: realmFileUrl, schemaVersion: 1) { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {

            }
        }
        Realm.Configuration.defaultConfiguration = config
        print(docDir.path)
        do {
            realm = try Realm()
        } catch {
            print("Error opening default realm", error)
        }
        
    }
    
    func add(_ group: GroupModel) {
        guard let dbRef = realm else { return }
        try? dbRef.write({
            dbRef.add(group)
        })
    }
    
    func remove(indexSet:IndexSet) {
        guard let index = indexSet.first else { return }
        let selectedGroup = self.groupsArray[index]
        let liveGroup = selectedGroup.thaw()!      //We cannot delete Frozen Object
        
        if(!liveGroup.isFrozen){
            try! self.realm!.write({
                self.realm!.delete(liveGroup)
            })
        }
    }
    
    func update(group:GroupModel){
        guard let dbRef = realm else { return }
        let liveGroup = group.thaw()!
        try! dbRef.write({
            liveGroup.groupTitle = self.updateTitle
        })
    }
}
