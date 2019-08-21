//
//  ContentView.swift
//  differentListConstruction
//
//  Created by Steedman Bass on 8/21/19.
//  Copyright © 2019 Steedman Bass. All rights reserved.
//

import SwiftUI


class TestData {
    
    let title: String
    let items: [String]
    var displayOrder: Int
    
    init(_ title: String, _ items: [String], _ displayOrder: Int) {
        self.title = title
        self.items = items
        self.displayOrder = displayOrder
    }
}

struct ContentView: View {
    
    
    
    
  func move(testData: TestData, set: IndexSet, to: Int) {
    
    print("xxl index set count on move is\(set.first!), count is \(set.count) and to is: \(to)")
//            mygroups.move(fromOffsets: set, toOffset: to)
    }
    
    
    var mygroups = [
        TestData( "Numbers",  ["1","2","3"], 0),
        TestData( "Letters",  ["A","B","C"], 0),
        TestData( "Symbols",  ["€","%","&"], 0)]
    var body: some View {
        
        NavigationView {
            
            List {
                ForEach(mygroups, id: \.title) { (gr: TestData) in
                    
                    Section(header: Text(gr.title)) {
                        ForEach(gr.items, id: \.self) { item in
                                    RowView(contents: item)
//                            RowView()

                        }.onMove{self.move(testData: self.mygroups, set: $0, to: $1)}
                            .onDelete{indexSet in print(indexSet)}
                            
                    }
                }
            }.listStyle(GroupedListStyle())
                .navigationBarItems(trailing: EditButton())

        }
        
    }
}


struct RowView: View {
//    var contents: TestData
    var contents: GenericStruct


    var body: some View {
//        return Text(contents.title)
        return Text("Bill")

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GenericStruct {
    let title = "generic struct"
}

let data = [GenericStruct(), GenericStruct(), GenericStruct()]
