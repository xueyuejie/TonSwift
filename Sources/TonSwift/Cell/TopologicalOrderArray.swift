//
//  File.swift
//  
//
//  Created by 薛跃杰 on 2023/1/6.
//

import Foundation

public struct TopologicalOrderArray {
    let cellHash: Data
    let cell: Cell
    
    public init(cellHash: Data, cell: Cell) {
        self.cellHash = cellHash
        self.cell = cell
    }
}
