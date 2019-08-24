//
//  ContentView.swift
//  differentListConstruction
//
//  Created by Steedman Bass on 8/21/19.
//  Copyright © 2019 Steedman Bass. All rights reserved.
//

import SwiftUI
import Foundation
import Combine

class AppData: ObservableObject {
    
//    var objectWillChange = PassthroughSubject<Void, Never>()
    let objectWillChange = ObservableObjectPublisher()
    
    let folderSource: [Folder]
    @Published var projects: [Project] {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        let folders = [Folder(title: "folder1", displayOrder: 0), Folder(title: "folder2", displayOrder: 1), Folder(title: "folder3", displayOrder: 2)  ]
        
        self.folderSource = folders
        self.projects = {
            
            var tempArray = [Project]()
            tempArray.append(Project(title: "project 0", displayOrder: 0, folder: folders[0]  ))
            tempArray.append(Project(title: "project 1", displayOrder: 1, folder: folders[0]  ))
            tempArray.append(Project(title: "project 2", displayOrder: 2, folder: folders[0]  ))
            
            
            tempArray.append(Project(title: "project 3", displayOrder: 0, folder: folders[1]  ))
            tempArray.append(Project(title: "project 4", displayOrder: 1, folder: folders[1]  ))
            tempArray.append(Project(title: "project 5", displayOrder: 2, folder: folders[1]  ))
            
            
            tempArray.append(Project(title: "project 6", displayOrder: 0, folder: folders[2]  ))
            tempArray.append(Project(title: "project 7", displayOrder: 1, folder: folders[2]  ))
            tempArray.append(Project(title: "project 8", displayOrder: 2, folder: folders[2]  ))
            
            return tempArray
        }()
        
    }
    
    
    func delete() {
        //dumbed-down static delete call to try to find ui bug
        self.projects.remove(at: 0)
        //
    }
}

struct ContentView: View {
    
    @EnvironmentObject var vm: AppData
    
    var body: some View {
        
        NavigationView {
            
            List {
                ForEach(vm.folderSource) { (folder: Folder)   in
                    return Section(header: Text(folder.title)) {
                        FolderView(folder: folder)
                    }
                }
            }.listStyle(GroupedListStyle())
                .navigationBarItems(trailing: EditButton())
        }
    }
}

struct FolderView: View {
    var folder: Folder
    @EnvironmentObject var vm: AppData
    
    
    var body: some View {
        let associatedProjects = vm.projects.filter{$0.folder == folder}
        
        return ForEach(associatedProjects) { (project: Project) in
            Text(project.title.uppercased())
        }.onDelete{index in self.vm.delete()}
    }
}


class Folder: Hashable, Equatable, Identifiable{
    
    let id = UUID()
    let title: String
    let displayOrder: Int
    
    
    init(title: String, displayOrder: Int) {
        self.title = title
        self.displayOrder = displayOrder
    }
    
    //make Equatable
    static func == (lhs: Folder, rhs: Folder) -> Bool {
        lhs.id == rhs.id
    }

    //make Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}



class Project: Hashable, Equatable, Identifiable {
    
    let id = UUID()
    let title: String
    let displayOrder: Int
    let folder: Folder
    
    init(title: String, displayOrder: Int, folder: Folder) {
        self.title = title
        self.displayOrder = displayOrder
        self.folder = folder
    }
    
    static func == (lhs: Project, rhs: Project) -> Bool {
        lhs.id == rhs.id
        
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}



//}.onDelete{self.vm.delete(projects: $0.map{associatedProjects[$0
//    ]})}
//    .onMove{ self.vm.move(projects: associatedProjects, set: $0, to: $1)}
//}


//    func delete(projects: [Project]) {
//
//        self.projects.remove(at: 0)
////        for p in projects {
////            self.projects.removeAll{$0 == p}
////        }
//    }
//
//.onMove{ self.vm.move(projects: associatedProjects, set: $0, to: $1)}


//func move(projects: [Project], set: IndexSet, to: Int) {
//
//     //        print("xxl index set count on move is\(set.first!), count is \(set.count) and to is: \(to)")
//     //            mygroups.move(fromOffsets: set, toOffset: to)
// }
