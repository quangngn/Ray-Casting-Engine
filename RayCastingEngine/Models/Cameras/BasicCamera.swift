//
//  BasicCamera.swift
//  RayCastingEngine
//
//  Created by Nguyễn Đức Quang on 12/21/20.
//

import MetalKit

class BasicCamera: Camera {
    
    // Variables
    var position: SIMD3<Float>
    var type: CameraType
    var projectionMatrix: matrix_float4x4 {
        matrix_float4x4.perspective(degreesFov: 45, aspectRatio: MainViewRenderer.aspectRatio, near: 0.1, far: 1000)
    }
    var viewMatrix: matrix_float4x4 {
        var viewMatrix = matrix_identity_float4x4
        viewMatrix.translate(direction: -position)
        return viewMatrix
    } 
    
    
    // Constructors
    init() {
        position = SIMD3<Float>(0, 0, 5)
        type = .Basic
    }
    
    
    // Functions
    func update() {
        // update the position of the camera here if need
    }
    
}
