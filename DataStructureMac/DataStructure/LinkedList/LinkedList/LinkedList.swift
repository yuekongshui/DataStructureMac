//
//  LinkedList.swift
//  DataStructureMac
//
//  Created by ma c on 2024/4/9.
//

import Foundation

class LinkedList<E: Equatable> {
	
	// MARK: 节点
	private final class Node {
		var prev: Node?
		var element: E?
		var next: Node?
		
		init(prev: Node?, element: E, next: Node?) {
			self.prev = prev
			self.element = element
			self.next = next
		}
	}
	
	private var first: Node?
	private var last: Node?
	private(set) var size: Int = 0
	
	init() {
	}
	
	// MARK: 内部方法 构造一个IndexOutOfBoundsException详细信息
	private func outOfBoundsMsg(index: Int) -> String {
		return "Index: "+index.formatted()+", Size: "+self.size.formatted();
	}
	
	// MARK: 内部方法 判断参数是否为现有元素的索引
	private func isElementIndex(index: Int) -> Bool {
		return index >= 0 && index < self.size
	}
	
	// MARK: 内部方法 判断参数是迭代器或添加操作的有效位置的索引
	private func isPositionIndex(index: Int) -> Bool {
		return index >= 0 && index <= self.size
	}
	
	// MARK: 内部方法 检查元素下标
	private func checkElementIndex(index: Int) throws {
		if (!self.isElementIndex(index: index)){
			throw ListException.IndexOutOfBoundsException(message: self.outOfBoundsMsg(index: index))
		}
	}
	
	// MARK: 内部方法 判断位置下标
	private func checkPositionIndex(index: Int) throws {
		if (!self.isPositionIndex(index: index)){
			throw ListException.IndexOutOfBoundsException(message: self.outOfBoundsMsg(index: index))
		}
	}
	
	// MARK: 内部 返回指定元素索引处的(非空)节点
	private func node(index: Int) -> Node {
		if (index < (size >> 1)) {
			var x = self.first
			for _ in 0..<index {
				x = x?.next
			}
			return x!
		} else {
			var x = self.last
			for _ in stride(from: size - 1, to: index, by: -1) {
				x = x?.prev
			}
			return x!
		}
	}
	
	// MARK: 内部方法 添加到最前节点
	private func linkFirst(element: E) {
		let newNode = Node(prev: nil, element: element, next: self.first)
		
		if let f = self.first {
			f.prev = newNode
		} else {
			self.last = newNode
		}
		
		self.first = newNode
		self.size += 1
	}
	
	// MARK: 内部方法 添加到最后节点
	private func linkLast(element: E) {
		let newNode = Node(prev: self.last, element: element, next: nil)
		
		if let l = self.last {
			l.next = newNode
		} else {
			self.first = newNode
		}
		
		self.last = newNode
		self.size += 1
	}
	
	// MARK: 内部方法 添加到目标节点
	private func linkBefore(element: E, target: Node) {
		let newNode = Node(prev: target.prev, element: element, next: target)
		
		if let pred = target.prev {
			pred.next = newNode
		} else {
			self.first = newNode
		}
		
		target.prev = newNode
		self.size += 1
	}
	
	// MARK: 内部方法 删除最前节点
	private func unlinkFirst(f: Node) throws -> E {
		let element = f.element!
		self.first = f.next
		
		if let next = f.next {
			next.prev = nil
		} else {
			self.last = nil
		}
		
		f.element = nil
		f.next = nil
		self.size -= 1
		
		return element
	}
	
	// MARK: 内部方法 删除最后节点
	private func unlinkLast(f: Node) -> E {
		let element = f.element!
		self.last = f.prev
		
		if let prev = f.prev {
			prev.next = nil
		} else {
			self.first = nil
		}
		
		f.element = nil
		f.prev = nil
		self.size -= 1
		
		return element
	}
	
	// MARK: 内部方法 删除节点
	private func unlink(x: Node) -> E {
		let element = x.element!
		let prev = x.prev
		let next = x.next
		
		if (prev == nil) {
			self.first = next
		} else {
			prev?.next = next
			x.prev = nil
		}
		
		if (next == nil) {
			last = prev;
		} else {
			next?.prev = prev;
			x.next = nil;
		}
		
		x.element = nil
		self.size -= 1
		return element
	}
	
	// MARK: 返回指定元素在此列表中第一次出现的索引，如果列表中不包含该元素，则返回-1
	func indexOf(element: E) -> Int {
		var index = 0
		
		var x = self.first
		while x != nil {
			if (element == x?.element) {
				return index
			}
			x = x?.next
			index += 1
		}
		
		return -1
	}
	
	// MARK: 返回指定元素在此列表中最后一次出现的索引，如果列表中不包含该元素，则返回-1
	func lastIndexOf(element: E) -> Int {
		var index = 0
		
		var x = self.last
		while x != nil {
			if (element == x?.element) {
				return index
			}
			x = x?.prev
			index += 1
		}
		
		return -1
	}
	
	// MARK: 如果列表中包含指定元素，则返回true
	func contains(element: E) -> Bool {
		return self.indexOf(element: element) != -1
	}
	
	// MARK: 将指定的元素附加到列表的末尾
	func add(element: E) -> Bool {
		self.linkLast(element: element);
		return true;
	}
	
	// MARK: 如果指定的元素存在，则从列表中删除它的第一个匹配项。如果该链表不包含该元素，则它不会改变
	func remove(element: E) -> Bool {
		var x = self.first
		while let currentNode = x {
			if element == currentNode.element {
				let _ = self.unlink(x: currentNode)
				return true
			}
			x = currentNode.next
		}
		
		return false
	}
	
	// MARK: 从列表中删除所有元素。这个列表在调用返回后将为空
	func clear() {
		var x = self.first
		while let currentNode = x {
			x = currentNode.next
			currentNode.prev = nil
			currentNode.element = nil
			currentNode.next = nil
		}
		
		self.first = nil
		self.last = nil
		self.size = 0
	}
	
	// MARK: 返回列表中指定位置的元素
	func get(index: Int) throws -> E {
		try self.checkElementIndex(index: index)
		return self.node(index: index).element!
	}
	
	// MARK: 用指定的元素替换列表中指定位置的元素
	func set(index: Int, e: E) throws -> E {
		try self.checkElementIndex(index: index)
		let x = self.node(index: index)
		let oldVal = x.element!
		x.element = e
		return oldVal
	}
	
	// MARK: 将指定的元素插入到列表中的指定位置。将当前位置(如果有)的元素以及后续的元素向右移动(在其下标上加1)
	func add(index: Int, element: E) throws {
		try self.checkPositionIndex(index: index)
		
		if (index == self.size) {
			self.linkLast(element: element)
		} else {
			self.linkBefore(element: element, target: self.node(index: index))
		}
	}
	
	// MARK: 删除列表中指定位置的元素。将后续元素向左移动(下标减1)。返回从列表中删除的元素
	func remove(index: Int) throws -> E {
		try self.checkElementIndex(index: index)
		return self.unlink(x: self.node(index: index))
	}
}
