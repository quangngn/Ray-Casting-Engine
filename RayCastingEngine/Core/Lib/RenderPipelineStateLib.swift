//
//  RenderPipelineState.swift
//  RayCastingEngine
//
//  Created by Nguyễn Đức Quang on 12/13/20.
//

import MetalKit

// MARK: - RenderPipelineState types
enum RenderPipelineStateType {
    case Basic
}


// MARK: - RenderPipelineState protocol
protocol RenderPipelineState {
    var name: String { get }
    var state: MTLRenderPipelineState? { get }
}


// MARK: - RenderPipelineState Library
class RenderPipelineStateLib {
    
    // Variables
    private static var renderPipelineStates: [RenderPipelineStateType: RenderPipelineState] = [:]
    
    
    // Functions
    // Call after RenderPipelineDescriptor Library is initialized
    static func initDefault() {
        registerRenderPipelineState(state: BasicRenderPipelineState(), type: .Basic)
    }
    
    static func registerRenderPipelineState(state: RenderPipelineState, type: RenderPipelineStateType) {
        renderPipelineStates.updateValue(state, forKey: type)
    }
    
    static func getRenderPipelineState(type: RenderPipelineStateType) -> MTLRenderPipelineState {
        return renderPipelineStates[type]!.state!
    }
}


// MARK: - Different types of RenderPipelineState
class BasicRenderPipelineState: RenderPipelineState {
    
    // Variables
    var name: String
    var state: MTLRenderPipelineState?
    
    
    // Constructors
    init() {
        name = "Basic Render Pipeline State"
        
        do {
            state = try Engine.device.makeRenderPipelineState(descriptor: RenderPipelineDescriptorLib.getRenderPipelineDescriptor(type: .Basic))
        } catch let error as NSError {
            print(error)
        }
    }
}

