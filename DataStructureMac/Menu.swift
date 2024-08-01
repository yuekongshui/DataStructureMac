//
//  Menu.swift
//  DataStructureMac
//
//  Created by ma c on 2024/4/9.
//

import Foundation
import SwiftUI
import OrderedCollections

class Menu: Identifiable, Hashable {
    static func == (lhs: Menu, rhs: Menu) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: String = UUID().uuidString
    var name: String
	var image: String?
    var view: AnyView?
    
	init(name: String, image: String?, view: some View) {
        self.name = name
		self.image = image
        self.view = AnyView(view)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

struct MainMenuModel {
	let mainMenuItems = {
		var menus = OrderedDictionary<String, Array<Menu>>()
		
		menus["链表"] = [
			Menu(name: "链表", image: nil, view: LinkedListView()),
			Menu(name:"双向链表", image: nil, view: DoubleLinkedListView()),
			Menu(name:"环形链表", image: nil, view: CircularLinkedListView()),
			Menu(name:"双向环形链表", image: nil, view: DoubleCircularLinkedListView())
		]
		menus["跳表"] = [Menu(name: "跳表", image: nil, view: SkipListView())]
		menus["栈"] = [Menu(name: "栈", image: nil, view: StackView())]
		menus["队列"] = [
			Menu(name: "队列", image: nil, view: QueueView()),
			Menu(name: "环形队列", image: nil, view: CircularQueueView()),
		]
		
		return menus
	}()
}
