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
    
    
    
    
  func move(testData: [TestData], set: IndexSet, to: Int) {
    
    print("xxl index set count on move is\(set.first!), count is \(set.count) and to is: \(to)")
        for item in testData {
//            mygroups.move(fromOffsets: set, toOffset: to)
        item.displayOrder = 1
        }
//        allProjects.sort{$0.displayOrder > $1.displayOrder}
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
                                    Text(item)
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
    var contents: TestData

    var body: some View {
        return Text(contents.title)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
