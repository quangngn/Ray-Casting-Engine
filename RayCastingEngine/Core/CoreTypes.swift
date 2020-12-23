//
//  CoreTypes.swift
//  RayCastingEngine
//
//  Created by Nguyễn Đức Quang on 12/13/20.
//

import simd

// MARK: - Vertex Definition
struct Vertex {
    var position: SIMD3<Float>
    var color: SIMD4<Float>
}


// MARK: - Model Constants Definition
struct ModelConstant {
    var modelMatrix = matrix_identity_float4x4
}


// MARK: - Scene Constants Definition
struct SceneConstant {
    var viewMatrix = matrix_identity_float4x4
    var projectionMatrix = matrix_identity_float4x4
}


