//
//  TestGameObject.swift
//  RayCastingEngine
//
//  Created by Nguyễn Đức Quang on 12/19/20.
//

import Foundation
import MetalKit

class TestGameObject: Node {
    
    // Variables
    var mesh: Mesh!
    var modelConstant = ModelConstant()
    var time: Float = 0
    
    
    // Constructors
    override init() {
        self.mesh = MeshLib.getMesh(type: .BasicRectangle)
        
        super.init()
        
        self.scale.x = 0.03
    }
    
    
    // Methods
    override func updateSelf() {
        self.orientation.z += 0.01
        updateModelConstant()
    }
    
    // Might be inefficient as there are two of model matrices.
    private func updateModelConstant() {
        self.modelConstant.modelMatrix = self.modelMatrix
    }
}


// MARK: - Renderable Extension
extension TestGameObject: Renderable {
    
    func doRender(renderCmdEncoder: MTLRenderCommandEncoder) {
        renderCmdEncoder.setRenderPipelineState(RenderPipelineStateLib.getRenderPipelineState(type: .Basic))
        renderCmdEncoder.setVertexBytes(&modelConstant, length: ModelConstant.size(), index: BufferIndex.modelConstant)
        renderCmdEncoder.setTriangleFillMode(.fill)
        renderCmdEncoder.setVertexBuffer(mesh.vertexBuffer, offset: 0, index: BufferIndex.vertexBuffer)
        renderCmdEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: mesh.vertexCount)
    }
}

