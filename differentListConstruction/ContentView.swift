//
//  ContentView.swift
//  differentListConstruction
//
//  Created by Steedman Bass on 8/21/19.
//  Copyright © 2019 Steedman Bass. All rights reserved.
//

import SwiftUI
import Foundation





class Folder: Hashable, Equatable {
    static func == (lhs: Folder, rhs: Folder) -> Bool {
        lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    
    
    
    var title: String
    var displayOrder: Int

     init(title: String, displayOrder: Int) {
        self.title = title
        self.displayOrder = displayOrder
    }
}

class Project: Hashable, Equatable {
    static func == (lhs: Project, rhs: Project) -> Bool {
        lhs.title == rhs.title
        
    }
    
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    
    
    
    var title: String
    var displayOrder: Int
    var folder: Folder

     init(title: String, displayOrder: Int, folder: Folder) {
        self.title = title
        self.displayOrder = displayOrder
        self.folder = folder
    }
    
  
}



class AppData: ObservableObject {
    
    func move(project: Project, set: IndexSet, to: Int) {
        
    //    let arr = testData.fil
        
        print("xxl index set count on move is\(set.first!), count is \(set.count) and to is: \(to)")
    //            mygroups.move(fromOffsets: set, toOffset: to)
        }
    
    
    func delete(projects: [Project]) {
        for p in projects {
            self.projects.removeAll{$0 == p}
            print("tty deleted \(p)")
        }
    }
    
    
    func folders() -> [Folder] {
        Array(Set(projects.map{$0.folder}))
    }
        
    
    var projects: [Project] = {
        var folderSource = [Folder(title: "folder1", displayOrder: 0), Folder(title: "folder2", displayOrder: 1), Folder(title: "folder3", displayOrder: 2)  ]
        
        
        var tempArray = [Project]()
        tempArray.append(Project(title: "project 0", displayOrder: 0, folder: folderSource[0]  ))
            tempArray.append(Project(title: "project 1", displayOrder: 1, folder: folderSource[0]  ))
                tempArray.append(Project(title: "project 2", displayOrder: 1, folder: folderSource[0]  ))
        
        
        tempArray.append(Project(title: "project 3", displayOrder: 0, folder: folderSource[1]  ))
                  tempArray.append(Project(title: "project 4", displayOrder: 1, folder: folderSource[1]  ))
                      tempArray.append(Project(title: "project 5", displayOrder: 1, folder: folderSource[1]  ))
        
        
               tempArray.append(Project(title: "project 6", displayOrder: 0, folder: folderSource[2]  ))
                         tempArray.append(Project(title: "project 7", displayOrder: 1, folder: folderSource[2]  ))
                             tempArray.append(Project(title: "project 8", displayOrder: 1, folder: folderSource[2]  ))


      
        return tempArray
        }()
    
    
    
    
    
}




struct ContentView: View {
    
    
    @ObservedObject var appData: AppData
    

    
    
    func sectionProjects(folder: Folder) -> [Project] {
        appData.projects.filter{$0.folder == folder}
    }
    
 
    
    var body: some View {
        
        NavigationView {
            
            List {
//                ForEach(mygroups, id: \.title) { (gr: TestData) in
                ForEach(appData.folders(), id: \.self) { (fold: Folder) in

                    Section(header: Text(fold.title)) {
                        ForEach(self.sectionProjects(folder: fold) , id: \.self) { proj in
                            
                        
//                            RowView(contents:  TestData("b", ["a"], 0))
                            RowView(project: proj)

                            //                            RowView(contents: item)

//                            RowView()

                        }
                            
                    }
                }
            }.listStyle(GroupedListStyle())
                .navigationBarItems(trailing: EditButton())

        }
        
    }
}


struct RowView: View {
    var project: Project
//    var contents: Int
//    var contents: SimpleClass



    var body: some View {
//        return Text(String(contents))
//        return Text("Bill")
        return Text(project.title)

    }
}


struct FolderView: View {
    var folder: Folder
   @ObservedObject var vm: AppData
    
    func projects(for folder: Folder) -> [Project] {
        return self.vm.projects.filter{ $0.folder == folder}
    }
    
    var body: some View {
        let localProjects: [Project] = self.projects(for: folder)
        
        return ForEach(localProjects, id: \.self) { (project: Project) in
            Text(project.title.uppercased())
        }.onDelete{self.vm.delete(projects: $0.map{localProjects[$0]})}
    }

}
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}




