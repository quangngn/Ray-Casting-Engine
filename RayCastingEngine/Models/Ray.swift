//
//  Ray.swift
//  RayCastingEngine
//
//  Created by Nguyễn Đức Quang on 12/21/20.
//

import MetalKit
import Foundation

class Ray: Node {
    
    // Variables
    // auto change position and the scale based on changing start and end. For now the orientation is not going to be changed
    var start = SIMD3<Float>(repeating: 0) {
        didSet {
            self.end += self.start - self.position
            self.position = self.start
        }
    }
    var end:SIMD3<Float> = SIMD3<Float>(repeating: 0) {
        didSet {
            let dx = end.x - start.x
            let dy = end.y - start.y
            self.scale.x = sqrt(dx * dx + dy * dy)
        }
    }
    var mesh: Mesh
    var modelConstant = ModelConstant()
    
    
    // Constructors
    init(start: SIMD3<Float>, orientationDeg: Float, length: Float, thickness: Float) {
        // the length of the ray
        self.start = start
        self.end = SIMD3<Float>(start.x + cos(orientationDeg.toRad) * length,
                                    start.y + sin(orientationDeg.toRad) * length,
                                    0)
        self.mesh = MeshLib.getMesh(type: .BasicRectangle)
        
        // init super
        super.init()
        
        // update position, scale, orientation
        self.scale.x = length
        self.scale.y = thickness
        
        self.orientation.z = orientationDeg.toRad
        
        self.position.x = start.x
        self.position.y = start.y
    }
    
    init(start:SIMD3<Float>, orientationRad: Float, length: Float, thickness: Float) {
        // the length of the ray
        self.start = start
        self.end = SIMD3<Float>(start.x + cos(orientationRad) * length,
                                    start.y + sin(orientationRad) * length,
                                    0)
        self.mesh = MeshLib.getMesh(type: .BasicRectangle)
        
        // init super
        super.init()
        
        // update position, scale, orientation
        self.scale.x = length
        self.scale.y = thickness
        
        self.orientation.z = orientationRad
        
        self.position.x = start.x
        self.position.y = start.y
    }
    
    
    // Methods
    // given 2 rays, find the intersection if possible
    static func getIntesection(ray1: Ray, ray2: Ray) -> SIMD3<Float>! {
        // extract the point from first ray
        let xS1 = ray1.start.x
        let yS1 = ray1.start.y
        let xE1 = ray1.end.x
        let yE1 = ray1.end.y
        
        // extract the point from second ray
        let xS2 = ray2.start.x
        let yS2 = ray2.start.y
        let xE2 = ray2.end.x
        let yE2 = ray2.end.y
        
        if ((xS1 - xE1) * (yS2 - yE2) - (xS2 - xE2) * (yS1 - yE1)) ==~ 0{
            // if two rays are parallel, we return nill
            return nil
        } else {
            var x: Float = 0
            var y: Float = 0
            let dx1: Float = xE1 - xS1
            let dx2: Float = xE2 - xS2
            let dy1: Float = yE1 - yS1
            let dy2: Float = yE2 - yS2
            
            if dx1 ==~ 0 {
                // the first line is likely to be vertical b1 is gonna explode
                x = (xE1 + xS1) / 2
                let slope2: Float = dy2 / dx2
                let b2: Float = yE2 - slope2 * xE2
                y = slope2 * x + b2
                
            } else if dx2 ==~ 0 {
                // the second line is likely to be vertical b2 is gonna explode
                x = (xE2 + xS2) / 2
                let slope1: Float = dy1 / dx1
                let b1: Float = yE1 - slope1 * xE1
                y = slope1 * x + b1
            } else {
                let slope1: Float = dy1 / dx1
                let slope2: Float = dy2 / dx2
                let b1: Float = yE1 - slope1 * xE1
                let b2: Float = yE2 - slope2 * xE2
                
                x = (b2 - b1) / (slope1 - slope2)
                y = slope1 * x + b1
            }
            
            if (x - xS1) * (x - xE1) > 0 ||
                (x - xS2) * (x - xE2) > 0 ||
                (y - yS1) * (y - yE1) > 0 ||
                (y - yS2) * (y - yE2) > 0 {
                // check if the intersection is out of lines' bounds
                return nil
            } else {
                return SIMD3<Float>(x, y, 0)
            }
        }
    }
    
    // give a center point and 2 other points (all on the same ray), return the point that is closer to the center
    static func closerPoint(center: SIMD3<Float>, original: SIMD3<Float>, candidate: SIMD3<Float>) -> SIMD3<Float>!{
        let dy1: Float = original.y - center.y
        let dx1: Float = original.x - center.x
        let dy2: Float = candidate.y - center.y
        let dx2: Float = candidate.x - center.x
        
        if  (dx1 * dx2 < 0) {
            // check if three points are not on the same ray or the center is between two points (which should not be
            // the case).
            print(dy1)
            print(dx1)
            print(dy2)
            print(dx2)
            print(center)
            print(original)
            print(candidate)
            return original
        } else {
            if abs(dx1) < abs(dx2) {
                return original
            } else {
                return candidate
            }
        }
    }
    
    // update the model constant based on the start and end location, remember that the orientation does not change
    override func updateSelf() {
        self.position = self.start
        self.scale.x = sqrt((end.x - start.x) * (end.x - start.x) + (end.y - start.y) * (end.y - start.y))
        
        updateModelConstant()
    }
    
    // Might be inefficient as there are two of model matrices.
    private func updateModelConstant() {
        
        self.modelConstant.modelMatrix = self.modelMatrix
    }
}


// MARK: - Renderable Extension for Ray object
extension Ray: Renderable {
    
    func doRender(renderCmdEncoder: MTLRenderCommandEncoder) {
        renderCmdEncoder.setRenderPipelineState(RenderPipelineStateLib.getRenderPipelineState(type: .Basic))
        renderCmdEncoder.setVertexBytes(&modelConstant, length: ModelConstant.size(), index: BufferIndex.modelConstant)
        renderCmdEncoder.setTriangleFillMode(.fill)
        renderCmdEncoder.setVertexBuffer(mesh.vertexBuffer, offset: 0, index: BufferIndex.vertexBuffer)
        renderCmdEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: mesh.vertexCount)
    }
}
