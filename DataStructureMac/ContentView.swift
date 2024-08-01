//
//  ContentView.swift
//  DataStructureMac
//
//  Created by ma c on 2024/4/9.
//

import SwiftUI
import OrderedCollections

//let menus: [String] = ["数组", "链表", "跳表", "栈", "队列", "树", "堆", "散列表", "图"]

class MenusStore: ObservableObject {
    @Published var selection: Menu?
}

struct ContentView: View {
    
    @StateObject var store = MenusStore()
    
	private var menus = MainMenuModel().mainMenuItems
    
    var body: some View {
        NavigationSplitView {
            SideBarView(menus: self.menus)
        } detail: {
            DetailView()
        }
        .environmentObject(self.store)
    }
}

// MARK: 侧边栏
struct SideBarView: View {
    
    @EnvironmentObject var store: MenusStore
    
    var menus = OrderedDictionary<String, Array<Menu>>()
    
    var body: some View {
        ScrollView() {
            ForEach(self.menus.keys, id: \.self) { tag in
                Section(header: Text(tag)) {
                    List(self.menus[tag]!, id: \.self, selection: self.$store.selection) { child in
                        Text(child.name)
                    }
                    .frame(height: 20  + CGFloat(24 * self.menus[tag]!.count))
                }
            }
        }
    }
}

// MARK: 详情
struct DetailView: View {
    
    @EnvironmentObject var store: MenusStore
    
    var body: some View {
        NavigationStack {
            VStack {
                if let selection = self.store.selection {
                    selection.view
                } else {
                    Text("请选择")
                }
            }
        }
        .toolbar(content: {
            EditButton()
        })
        .navigationTitle(self.store.selection?.name ?? "数据结构")
    }
}

// MARK: 按钮
struct EditButton: View {
    var body: some View {
        Button(action: {
            print("edit")
        }, label: {
            Text("Edit")
        })
    }
}

#Preview {
    ContentView()
}
