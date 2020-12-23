//
//  MainViewRenderer.swift
//  RayCastingEngine
//
//  Created by Nguyễn Đức Quang on 12/13/20.
//

import MetalKit

class MainViewRenderer: NSObject {
    
    // Variables
    private static var view: MTKView!
    static var width: Float = 0
    static var height: Float = 0
    static var aspectRatio: Float {
        return MainViewRenderer.width / MainViewRenderer.height
    }
    
    
    // Constructors
    init(_ mtkView: MTKView) {
        MainViewRenderer.width = Float(mtkView.bounds.width)
        MainViewRenderer.height = Float(mtkView.bounds.height)
    }
    
}


//MARK: - Extension to do render
extension MainViewRenderer: MTKViewDelegate {
    
    // Functions
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        MainViewRenderer.width = Float(view.bounds.width)
        MainViewRenderer.height = Float(view.bounds.height)
    }
    
    func draw(in view: MTKView) {
        
        guard  let drawable = view.currentDrawable, let renderDescriptor = view.currentRenderPassDescriptor else { return }
        
        let commandBuffer = Engine.cmdQueue.makeCommandBuffer()
        let renderCmdEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderDescriptor)
        
        // update the node in the scene
        SceneManager.updateScene(renderCmdEncoder: renderCmdEncoder!, deltaTime: 1/Float(view.preferredFramesPerSecond))
        
        renderCmdEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}

