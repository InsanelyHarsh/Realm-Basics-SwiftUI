//
//  DetailView.swift
//  Realm-Basics-SwfitUI
//
//  Created by Harsh Yadav on 24/12/22.
//

import SwiftUI

struct DetailView: View {
    @StateObject var detailVM:DetailViewModel = DetailViewModel()
    
    var group:GroupModel
    var body: some View {
        VStack{
            HStack{
                TextField("Add Item", text: $detailVM.itemTitle)
                    .textFieldStyle(.roundedBorder)
                Button {
                    self.detailVM.addNewItem(to: group)
                    self.detailVM.fetchItems(of: group)
                } label: {
                    Image(systemName: "plus.circle")
                }
                .disabled(detailVM.itemTitle.isEmpty)
            }.padding()
            
            if(self.detailVM.itemsArray.isEmpty){
                Text("No Items")
            }
            else{
                List{
                    ForEach(self.detailVM.itemsArray) { item in
                        Text(item.name)
                    }.onDelete(perform: self.detailVM.remove)
                        
                }
            }
            Spacer()
        }
        .onAppear{
            self.detailVM.fetchItems(of: group)
        }
        .navigationTitle(group.groupTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(group: GroupModel(groupTitle: "The Boys"))
    }
}
