//
//  Walls.swift
//  RayCastingEngine
//
//  Created by Nguyễn Đức Quang on 12/21/20.
//

import MetalKit

class Walls:Node {
    
    // Constructors
    init(thickness: Float) {
        super.init()
        
        // add each wall is
        let numWalls = Int.random(in: 10..<20)
        
        for _ in 0..<numWalls {
            let xStart = Float.random(in: -3...3)
            let yStart = Float.random(in: -3...3)
            
            let start = SIMD3<Float>(xStart, yStart, 0)
            let orientation = Float.random(in: -Float.pi * 2...Float.pi * 2)
            let length = Float.random(in: 0.5...5)
            
            self.addChild(newNode: Ray(start: start, orientationRad: orientation, length: length, thickness: thickness))
        }
    }
}
