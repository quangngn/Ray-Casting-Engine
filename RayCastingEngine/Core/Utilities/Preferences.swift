//
//  Preferences.swift
//  RayCastingEngine
//
//  Created by Nguyễn Đức Quang on 12/13/20.
//

import MetalKit

// MARK: - Constants for preferences
// Clear color constants for MainView
enum ClearColor {
    
    static let black = MTLClearColor(red: 0, green: 0, blue: 0, alpha: 1)
    static let white = MTLClearColor(red: 1, green: 1, blue: 1, alpha: 1)
    static let darkGray = MTLClearColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.1)
    
}


// MARK: - Preferences for MainView
class MainViewPreferences {
    
    static let clearColor: MTLClearColor = ClearColor.black
    static let pixelFormat: MTLPixelFormat = .bgra8Unorm
    static let depthPixelFormat: MTLPixelFormat = .depth32Float
    
}


// MARK: - Constants for Color
enum BasicColor {
    static let white = SIMD4<Float>(1,1,1,1)
}


// MARK: - Constants for Buffer Index
// must match MetalUtil.metal
enum BufferIndex {
    static let vertexBuffer:Int = 0
    static let modelConstant:Int = 1
    static let sceneConstant:Int = 2
}


// MARK: - Constants for VertexDescriptor Index
// must match MetalUtil.metal
enum VertexDescriptorAttrIndex {
    static let position:Int = 0
    static let color:Int = 1
}


// MARK: - RAY LENGTH
enum RayConstant {
    static let rayDefaultLength: Float = 10
    static let rayDefaultThickness: Float = 0.005
    static let wallDefaultThickness: Float = 0.02
}
