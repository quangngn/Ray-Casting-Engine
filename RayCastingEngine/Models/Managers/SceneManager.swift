//
//  SceneManager.swift
//  RayCastingEngine
//
//  Created by Nguyễn Đức Quang on 12/20/20.
//

import MetalKit

// MARK: - Scene types
enum SceneType {
    case Basic
}


// MARK: - Scene Manager class
class SceneManager {
    
    // Variables
    private(set) static var currentScene: Scene!
    
    
    // Methods
    static func initDefault() {}
    
    static func setSence(type: SceneType) {
        switch type {
        case .Basic:
            currentScene = BasicScene()
        }
    }
    
    static func getCurrentScene() -> Scene {
        return currentScene
    }
    
    static func updateScene(renderCmdEncoder: MTLRenderCommandEncoder, deltaTime: Float) {
        // update the current scene graph (aka recursively update its children)
        currentScene.update()
        
        // render the entire scene graph by recursively render its children
        currentScene.render(renderCmdEncoder: renderCmdEncoder)
    }
    
}
