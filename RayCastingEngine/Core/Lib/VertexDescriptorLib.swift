//
//  VertexDescriptor.swift
//  RayCastingEngine
//
//  Created by Nguyễn Đức Quang on 12/13/20.
//

import MetalKit

// MARK: - Vertex Descriptor types
enum VertexDescriptorType {
    case Basic
}


// MARK: - Vertex Descriptor protocol
protocol VertexDescriptor {
    var name: String { get }
    var descriptor: MTLVertexDescriptor { get }
}


// MARK: - Vertex Descriptor Library
class VertexDescriptorLib {
    
    // Variables
    private static var vertexDescriptors: [VertexDescriptorType: VertexDescriptor] = [:]
    
    
    // Functions
    static func initDefault() {
        registerVertexDescriptor(descriptor: BasicVertexDescriptor(), type: .Basic)
    }
    
     static func registerVertexDescriptor(descriptor: VertexDescriptor, type: VertexDescriptorType) {
        vertexDescriptors.updateValue(descriptor, forKey: type)
    }
    
    static func getVertexDescriptor(type: VertexDescriptorType) -> MTLVertexDescriptor {
        return vertexDescriptors[type]!.descriptor
    }
}


// MARK: - Different types of Vertex Descriptors
struct BasicVertexDescriptor: VertexDescriptor {
    
    // Variables
    var name: String
    var descriptor: MTLVertexDescriptor
    
    
    // Constructors
    init() {
        name = "Basic Vertex Descriptor"
        
        descriptor = MTLVertexDescriptor()
        
        // Descriptor follow the vertex descriptor in the CoreTypes.swift
        // position
        descriptor.attributes[VertexDescriptorAttrIndex.position].format = .float3
        descriptor.attributes[VertexDescriptorAttrIndex.position].offset = 0
        descriptor.attributes[VertexDescriptorAttrIndex.position].bufferIndex = BufferIndex.vertexBuffer;
        
        // color
        descriptor.attributes[VertexDescriptorAttrIndex.color].format = .float4
        descriptor.attributes[VertexDescriptorAttrIndex.color].offset = MemoryLayout<SIMD3<Float>>.stride
        descriptor.attributes[VertexDescriptorAttrIndex.color].bufferIndex = BufferIndex.vertexBuffer;
        
        // set the layout
        descriptor.layouts[0].stride = Vertex.stride()
    }
}


