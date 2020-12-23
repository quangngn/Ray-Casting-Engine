//
//  MeshLib.swift
//  RayCastingEngine
//
//  Created by Nguyễn Đức Quang on 12/19/20.
//

import MetalKit


// MARK: - Mesh types
enum MeshTypes {
    case BasicRectangle
}


// MARK: - Mesh protocol
protocol Mesh {
    var vertexBuffer: MTLBuffer! { get }
    var vertexCount: Int! { get }
}


// MARK: - Mesh Library
class MeshLib {
    
    // Variables
    static var meshes: [MeshTypes: Mesh] = [:]
    
    
    // Methods
    // initDefault() must be called in Engine.swift, after the device is initialized
    static func initDefault() {
        registerMesh(mesh: BasicRectangleMesh(), type: .BasicRectangle)
    }
    
    static func registerMesh(mesh: Mesh, type: MeshTypes) {
        meshes.updateValue(mesh, forKey: type)
    }
    
    static func getMesh(type: MeshTypes) -> Mesh {
        return meshes[type]!
    }
}


// MARK: - Different types of Mesh
class BasicRectangleMesh: Mesh {
    
    var vertexBuffer: MTLBuffer!
    var vertexCount: Int!
    var vertices: [Vertex]!
    
    init() {
        // define the vertices
        vertices = [
            // Upper triangle of the quad
            Vertex(position: SIMD3<Float>(1, -0.5, 0), color: BasicColor.white),
            Vertex(position: SIMD3<Float>(1, 0.5, 0), color: BasicColor.white),
            Vertex(position: SIMD3<Float>(0, 0.5, 0), color: BasicColor.white),

            // Lower triangle of the quad
            Vertex(position: SIMD3<Float>(0, 0.5, 0), color: BasicColor.white),
            Vertex(position: SIMD3<Float>(0, -0.5, 0), color: BasicColor.white),
            Vertex(position: SIMD3<Float>(1, -0.5, 0), color: BasicColor.white)
        ]
        
        // set the vertex count
        vertexCount = vertices.count
        
        // create the vertexBuffer
        vertexBuffer = Engine.device.makeBuffer(bytes: vertices, length: Vertex.stride(vertexCount), options: [])
    }
}





