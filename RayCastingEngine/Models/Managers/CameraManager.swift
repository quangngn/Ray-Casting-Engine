//
//  CameraManager.swift
//  RayCastingEngine
//
//  Created by Nguyễn Đức Quang on 12/21/20.
//

import MetalKit

// MARK: - Camera Types
enum CameraType {
    case Basic
}


// MARK: - Camera Manager
class CameraManager {
    
    // Variables
    static var cameras: [CameraType:Camera] = [:]
    static var currentCamera: Camera!
    
    
    // Functions
    static func initDefault() {
        registerCamera(camera: BasicCamera(), type: .Basic)
    }
    
    static func registerCamera(camera: Camera, type: CameraType) {
        cameras.updateValue(camera, forKey: type)
    }
    
    static func setCamera(type: CameraType) {
        currentCamera = cameras[type]
    }
    
    static func update() {
        currentCamera.update()
    }
    
}
