//
//  Menu.swift
//  DataStructureMac
//
//  Created by ma c on 2024/4/9.
//

import Foundation
import SwiftUI

class Menu: Identifiable, Hashable {
    static func == (lhs: Menu, rhs: Menu) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: String = UUID().uuidString
    var name: String
    var view: AnyView?
    
    init(name: String, view: some View) {
        self.name = name
        self.view = AnyView(view)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
