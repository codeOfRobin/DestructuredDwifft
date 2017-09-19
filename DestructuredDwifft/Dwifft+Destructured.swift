//
//  Dwifft+Destructured.swift
//  DestructuredDwifft
//
//  Created by Robin Malhotra on 19/09/17.
//  Copyright © 2017 Robin Malhotra. All rights reserved.
//

import Dwifft

public extension Dwifft {
	public static func destructuredDiff<Value>(_ lhs: [Value], _ rhs: [Value], section: Int = 0) -> ([IndexPath], [IndexPath]) where Value : Equatable {
		let diff = Dwifft.diff(lhs, rhs)
		let inserts: [IndexPath] = diff.flatMap {
			if case .insert(let index, _) = $0 {
				return index
			} else {
				return nil
			}
			}.map{ IndexPath.init(row: $0, section: section) }
		
		let deletes: [IndexPath] = diff.flatMap {
			if case .delete(let index, _) = $0 {
				return index
			} else {
				return nil
			}
			}.map{ IndexPath.init(row: $0, section: section) }
		
		return (inserts, deletes)
	}
}

