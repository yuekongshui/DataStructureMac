//
//  ListException.swift
//  DataStructureMac
//
//  Created by 水月空 on 2024/8/1.
//

import Foundation

enum ListException: Error {
	case IndexOutOfBoundsException(message: String)
}
