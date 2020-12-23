//
//  Utilities.swift
//  RayCastingEngine
//
//  Created by Nguyễn Đức Quang on 12/13/20.
//

import simd

// MARK: - Sizeable protocol
protocol sizeable {
    static func size(_ count: Int) -> Int
    static func stride(_ count: Int) -> Int
}


extension sizeable {
    static func size(_ count: Int) -> Int {
        return MemoryLayout<Self>.size * count
    }
    
    static func stride(_ count: Int) -> Int {
        return MemoryLayout<Self>.stride * count
    }
    
    static func size() -> Int {
        return MemoryLayout<Self>.size
    }
    
    static func stride() -> Int {
        return MemoryLayout<Self>.stride
    }
}


// MARK: - Sizeable extension
extension Float: sizeable {}
extension SIMD3: sizeable {}
extension SIMD4: sizeable {}
extension Vertex: sizeable {}
extension ModelConstant: sizeable {}
extension SceneConstant: sizeable {}

