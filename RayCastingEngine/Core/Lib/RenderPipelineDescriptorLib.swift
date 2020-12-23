//
//  RenderPipelineDescriptorLib.swift
//  RayCastingEngine
//
//  Created by Nguyễn Đức Quang on 12/13/20.
//

import MetalKit

// MARK: - RenderPipelineDescriptor types
enum RenderPipelineDescriptorType {
    case Basic
}


// MARK: - RenderPipelineDescriptor protocol
protocol RenderPipelineDescriptor {
    var name: String { get }
    var descriptor: MTLRenderPipelineDescriptor { get }
}


// MARK: - RenderPipelineDescriptor Library
class RenderPipelineDescriptorLib {
    
    // Variables
    private static var renderPipelineDescriptors: [RenderPipelineDescriptorType: RenderPipelineDescriptor] = [:]
    
    
    // Functions
    static func initDefault() {
        // call after Shader libraries are initialized
        registerRenderPipelineDescriptor(descriptor: BasicRenderPipelineDescriptor(), type: .Basic)
    }
    
    static func registerRenderPipelineDescriptor(descriptor: RenderPipelineDescriptor, type: RenderPipelineDescriptorType) {
        renderPipelineDescriptors.updateValue(descriptor, forKey: type)
    }
    
    static func getRenderPipelineDescriptor(type: RenderPipelineDescriptorType) -> MTLRenderPipelineDescriptor {
        return renderPipelineDescriptors[type]!.descriptor
    }
}


// MARK: - Different types of RenderPipelineDescriptor
class BasicRenderPipelineDescriptor: RenderPipelineDescriptor {
    
    // Variables
    var name: String
    var descriptor: MTLRenderPipelineDescriptor
    
    
    // Constructors
    init() {
        name = "Basic Render Pipeline Descriptor"
        
        // set properties for descriptor
        descriptor = MTLRenderPipelineDescriptor()
        descriptor.colorAttachments[0].pixelFormat = MainViewPreferences.pixelFormat
        descriptor.vertexFunction = VertexShaderLib.getVertexShader(type: .Basic)
        descriptor.fragmentFunction = FragmentShaderLib.getFragmentShader(type: .Basic)
        descriptor.vertexDescriptor = VertexDescriptorLib.getVertexDescriptor(type: .Basic)
    }
}
