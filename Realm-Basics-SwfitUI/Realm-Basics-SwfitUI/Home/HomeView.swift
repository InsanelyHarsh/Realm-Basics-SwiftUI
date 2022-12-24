//
//  HomeView.swift
//  Realm-Basics-SwfitUI
//
//  Created by Harsh Yadav on 24/12/22.
//

import SwiftUI
import RealmSwift
struct HomeView: View {
    @StateObject var homeVM:HomeViewModel = HomeViewModel()
    @State var showAlert:Bool = false
    @State var updateAlert:Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    ForEach(homeVM.groupsArray) { group in //frozen group
                        VStack{
                            NavigationLink(value: group) {
                                LabeledContent("\(group.groupTitle)", value: "\(group.items.count)")
                            }
                        }
                    }.onDelete(perform: self.homeVM.remove)
                }
            }
            .onAppear{
                self.homeVM.fetchData()
            }
            .navigationTitle("Home")
            .navigationDestination(for: GroupModel.self, destination: { group in
                DetailView(group: group)
            })
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.homeVM.newGroupTitle = ""
                        self.showAlert.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            })
            .alert("Enter Group Title", isPresented: $showAlert) {
                TextField("Group Name", text: $homeVM.newGroupTitle)
                Button("Done", action: {
                    self.homeVM.add(GroupModel(groupTitle: homeVM.newGroupTitle))
                    self.homeVM.fetchData()
                })
            }
        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}





