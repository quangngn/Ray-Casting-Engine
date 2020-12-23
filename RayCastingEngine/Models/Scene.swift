//
//  Scene.swift
//  RayCastingEngine
//
//  Created by Nguyễn Đức Quang on 12/20/20.
//

/*
 This is the root of the scene graph and the it also has the camera control.
 */

import MetalKit

class Scene: Node {
    
    // Variables
    var sceneConstant = SceneConstant()
    var camera: Camera {
        return CameraManager.currentCamera
    }
    
    // Constuctors
    override init() {
        super.init()
    }
    
    // Methods
    override func renderSelf(renderCmdEncoder: MTLRenderCommandEncoder) {
        super.renderSelf(renderCmdEncoder: renderCmdEncoder)
        renderCmdEncoder.setVertexBytes(&sceneConstant, length: SceneConstant.stride(), index: BufferIndex.sceneConstant) 
    }
    
    override func updateSelf() {
        updateSceneConstant()
    }
    
    override func render(renderCmdEncoder: MTLRenderCommandEncoder) {
        // add scene constant to the buffer, this has nothing to do with renderSelf() tho
        renderCmdEncoder.setVertexBytes(&sceneConstant, length: SceneConstant.stride(), index: BufferIndex.sceneConstant)
        
        // call the rest of the normal render function
        super.render(renderCmdEncoder: renderCmdEncoder)
    }
    
    private func updateSceneConstant() {
        // this function will read projection matrix and the view matrix from the current camera.
        sceneConstant.projectionMatrix = camera.projectionMatrix
        sceneConstant.viewMatrix = camera.viewMatrix
    }
}
