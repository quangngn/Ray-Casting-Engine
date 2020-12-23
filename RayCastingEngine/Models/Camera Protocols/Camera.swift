//
//  Camera.swift
//  RayCastingEngine
//
//  Created by Nguyễn Đức Quang on 12/21/20.
//

import MetalKit

protocol Camera {
    
    // Variables
    var position: SIMD3<Float> { get set }
    var type: CameraType { get }
    var projectionMatrix: matrix_float4x4 { get }
    var viewMatrix: matrix_float4x4 { get }
    
    
    // Functions
    func update()
}
