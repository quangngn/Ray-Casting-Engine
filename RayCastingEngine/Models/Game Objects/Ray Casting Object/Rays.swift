//
//  Rays.swift
//  RayCastingEngine
//
//  Created by Nguyễn Đức Quang on 12/22/20.
//

import MetalKit

class Rays: Node {
    var time: Float = 0
    
    // Variables
    // if we change the position of the
    
    // Constructors
    init(position: SIMD3<Float>, thickness: Float) {
        super.init()
        
        self.position = position
        
        // add rays
        var angleRad: Float = 0
        while angleRad < Float.pi * 2 {
            self.addChild(newNode: Ray(start: position, orientationRad: angleRad, length: RayConstant.rayDefaultLength, thickness: thickness))
            angleRad += Float.pi / 10
        }
    }
    
    
    // Functions
    func updateChildrenPosition() {
        // update the position of each ray's start
        self.position.x = cos(time)
        time += 0.01
        for child in self.children {
            (child as! Ray).start = self.position
        }
        
    }
}
