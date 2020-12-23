//
//  Node.swift
//  RayCastingEngine
//
//  Created by Nguyễn Đức Quang on 12/19/20.
//

import MetalKit

class Node: NSObject {
    
    // Variables
    var position = SIMD3<Float>(repeating: 0)
    var scale = SIMD3<Float>(repeating: 1)
    var orientation = SIMD3<Float>(repeating: 0)
    var children:[Node] = []
    var modelMatrix: matrix_float4x4 {
        var modelMatrix = matrix_identity_float4x4
        
        // translate to the general position
        modelMatrix.translate(direction: position)
    
        // rotate to the specific angle
        modelMatrix.rotate(angle: orientation.x, axis: X_AXIS)
        modelMatrix.rotate(angle: orientation.y, axis: Y_AXIS)
        modelMatrix.rotate(angle: orientation.z, axis: Z_AXIS)
        
        // scale by factor
        modelMatrix.scale(factor: scale)
        
        return modelMatrix
    }
    
    
    // Constructors
    override init() {}
    
    init(position: SIMD3<Float>, scale: SIMD3<Float>, orientation: SIMD3<Float>) {
        self.position = position
        self.scale = scale
        self.orientation = orientation
    }
    
    
    // Methods
    func addChild(newNode: Node) {
        self.children.append(newNode)
    }
    
    // this should contains the logic of updating one self
    func updateSelf() {}
    
    func renderSelf(renderCmdEncoder: MTLRenderCommandEncoder) {
        // render self
        if let renderable = self as? Renderable {
            renderable.doRender(renderCmdEncoder: renderCmdEncoder)
        }
    }
    
    func update() {
        // update self
        self.updateSelf()
        
        // update children
        for child in children {
            child.update()
        }
    }
    
    func render(renderCmdEncoder: MTLRenderCommandEncoder) {
        renderSelf(renderCmdEncoder: renderCmdEncoder)
        
        // render children
        for child in children {
            child.render(renderCmdEncoder: renderCmdEncoder)
        }
    }
}
