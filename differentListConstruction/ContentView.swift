//
//  ContentView.swift
//  differentListConstruction
//
//  Created by Steedman Bass on 8/21/19.
//  Copyright © 2019 Steedman Bass. All rights reserved.
//

import SwiftUI
import Foundation


class TestData: Equatable, Hashable {
    
    
    static func ==(lhs: TestData, rhs: TestData) -> Bool {
        return lhs.title == rhs.title
    }
    
   func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(displayOrder)
    }

    
    
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
    
    
    
    
  func move(testData: [GenericStruct], set: IndexSet, to: Int) {
    
    print("xxl index set count on move is\(set.first!), count is \(set.count) and to is: \(to)")
//            mygroups.move(fromOffsets: set, toOffset: to)
    }
    
    var mod = genericStructModel
    var mygroups = [
        TestData( "Numbers",  ["1","2","3"], 0),
        TestData( "Letters",  ["A","B","C"], 0),
        TestData( "Symbols",  ["€","%","&"], 0)]
    var body: some View {
        
        NavigationView {
            
            List {
//                ForEach(mygroups, id: \.title) { (gr: TestData) in
                ForEach(mygroups, id: \.self) { (td: TestData) in

                    Section(header: Text(td.title)) {
                        ForEach(td.items, id: \.self) { item in
                        
//                            RowView(contents:  TestData("b", ["a"], 0))
                            RowView(contents: item)

                            //                            RowView(contents: item)

//                            RowView()

                        }.onMove{self.move(testData: self.mod, set: $0, to: $1)}
                            .onDelete{indexSet in print(indexSet)}
                            
                    }
                }
            }.listStyle(GroupedListStyle())
                .navigationBarItems(trailing: EditButton())

        }
        
    }
}


struct RowView: View {
    var contents: String
//    var contents: Int
//    var contents: SimpleClass



    var body: some View {
//        return Text(String(contents))
//        return Text("Bill")
        return Text(contents)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




struct GenericStruct: Identifiable {
    let id = UUID()
let title = "generic struct"
    let array = [1,2,3]
}
let genericStructModel = [GenericStruct(), GenericStruct(), GenericStruct()]

class SimpleClass{
    let simpleClassName = "simpleClass"
}
