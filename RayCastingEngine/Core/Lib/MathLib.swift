//
//  MathLib.swift
//  RayCastingEngine
//
//  Created by Nguyễn Đức Quang on 12/19/20.
//

import Foundation
import MetalKit

// MARK: - Matrix operations for transformations
// these would be nice to moved to the GPU
public var X_AXIS = SIMD3<Float>(1,0,0)
public var Y_AXIS = SIMD3<Float>(0,1,0)
public var Z_AXIS = SIMD3<Float>(0,0,1)

extension matrix_float4x4 {
    
    // Should be call create translation matrix
    // We need to double check how
    mutating func translate(direction: SIMD3<Float>){
        let x = direction.x
        let y = direction.y
        let z = direction.z
        
        var translationMatrix = matrix_identity_float4x4
        
        translationMatrix[3, 0] = x
        translationMatrix[3, 1] = y
        translationMatrix[3, 2] = z
        
        self = matrix_multiply(translationMatrix, self)
    }
    
    
    // Should be called create scale matrix
    mutating func scale(factor: SIMD3<Float>) {
        var result = matrix_identity_float4x4
                
        let x: Float = factor.x
        let y: Float = factor.y
        let z: Float = factor.z
                
        result.columns = (
            SIMD4<Float>(x,0,0,0),
            SIMD4<Float>(0,y,0,0),
            SIMD4<Float>(0,0,z,0),
            SIMD4<Float>(0,0,0,1)
        )
                
        self = matrix_multiply(self, result)
    }
    
    
    // Should be called create rotation matrix
    mutating func rotate(angle: Float, axis: SIMD3<Float>) {
        let x = axis.x
        let y = axis.y
        let z = axis.z
        
        let c = cos(angle)
        let s = sin(angle)
        
        let mc = 1 - c
        
        let c1r1: Float = x * x * mc + c
        let c1r2: Float = x * y * mc + z * s
        let c1r3: Float = x * z * mc - y * s
        let c1r4: Float = 0.0

        let c2r1: Float = y * x * mc - z * s
        let c2r2: Float = y * y * mc + c
        let c2r3: Float = y * z * mc + x * s
        let c2r4: Float = 0.0

        let c3r1: Float = z * x * mc + y * s
        let c3r2: Float = z * y * mc - x * s
        let c3r3: Float = z * z * mc + c
        let c3r4: Float = 0.0

        let c4r1: Float = 0.0
        let c4r2: Float = 0.0
        let c4r3: Float = 0.0
        let c4r4: Float = 1.0
        
        let rotationMatrix = matrix_float4x4(columns:(
            SIMD4<Float>(c1r1, c1r2, c1r3, c1r4),
            SIMD4<Float>(c2r1, c2r2, c2r3, c2r4),
            SIMD4<Float>(c3r1, c3r2, c3r3, c3r4),
            SIMD4<Float>(c4r1, c4r2, c4r3, c4r4)
        ))
        
        self = matrix_multiply(self, rotationMatrix)
    }
    
    public static func perspective(degreesFov: Float, aspectRatio: Float, near: Float, far: Float) -> matrix_float4x4 {
        let fov = degreesFov.toRad;
        
        let t = tan(fov / 2)
        
        let x: Float = 1 / (aspectRatio * t)
        let y: Float = 1 / t
        let z: Float = -((far + near) / (far - near))
        let w: Float = -((2 * far * near) / (far - near))
        
        let result = matrix_float4x4(SIMD4<Float>(x, 0, 0, 0),
                                     SIMD4<Float>(0, y, 0, 0),
                                     SIMD4<Float>(0, 0, z, -1),
                                     SIMD4<Float>(0, 0, w, 0))
        return result
    }

}


// MARK: - Float operations for geometry
extension Float {
    var toRad: Float {
        return (self / 180) * Float.pi
    }
    
    var toDeg: Float {
        return self * (180 / Float.pi)
    }
}


// MARK: - Infix definitions
infix operator !=~
func !=~ (left: Float, right:Float) -> Bool {
    return abs(left - right) >= 1e-4
}

infix operator ==~
func ==~ (left: Float, right:Float) -> Bool {
    return abs(left - right) < 1e-4
}

