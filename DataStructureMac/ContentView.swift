//
//  ContentView.swift
//  DataStructureMac
//
//  Created by ma c on 2024/4/9.
//

import SwiftUI

//let menus: [String] = ["数组", "链表", "跳表", "栈", "队列", "树", "堆", "散列表", "图"]

class MenusStore: ObservableObject {
    @Published var selection: Menu?
}

struct ContentView: View {
    
    @StateObject var store = MenusStore()
    
    var menus: Dictionary<String, Array<Menu>> = Dictionary()
    
    // MARK: 初始化菜单
    init() {
        menus["链表"] = [
            Menu(name: "链表", view: LinkedListView()),
            Menu(name:"双向链表", view: DoubleLinkedListView()),
            Menu(name:"环形链表", view: CircularLinkedListView()),
            Menu(name:"双向环形链表", view: DoubleCircularLinkedListView())
        ]
        menus["跳表"] = [Menu(name: "跳表", view: SkipListView())]
        menus["栈"] = [Menu(name: "栈", view: StackView())]
        menus["队列"] = [
            Menu(name: "队列", view: QueueView()),
            Menu(name: "环形队列", view: CircularQueueView()),
        ]
    }
    
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
    
    var menus: Dictionary<String, Array<Menu>> = Dictionary()
    
    var body: some View {
        ScrollView() {
            ForEach(self.menus.keys.sorted(), id: \.self) { tag in
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
