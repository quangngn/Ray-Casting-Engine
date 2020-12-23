//
//  Engine.swift
//  RayCastingEngine
//
//  Created by Nguyễn Đức Quang on 12/13/20.
//

import MetalKit

class Engine {
    
    // Variables
    static var device: MTLDevice!
    static var cmdQueue: MTLCommandQueue!
    
    
    // Functions
    static func initDefault(device: MTLDevice) {
        // init variables
        Engine.device = device
        Engine.cmdQueue = Engine.device.makeCommandQueue()
        
        // init other libraries and component of the Engine
        VertexShaderLib.initDefault()
        FragmentShaderLib.initDefault()
        VertexDescriptorLib.initDefault()
        RenderPipelineDescriptorLib.initDefault()
        RenderPipelineStateLib.initDefault()
        MeshLib.initDefault()
    }
}
