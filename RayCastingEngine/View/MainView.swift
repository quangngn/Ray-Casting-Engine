//
//  MainView.swift
//  RayCastingEngine
//
//  Created by Nguyễn Đức Quang on 12/13/20.
//

// Mainly Handle input

import MetalKit
 
class MainView: MTKView {
    
    // Variables
    var renderer: MainViewRenderer!
    
    
    // Constructors
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        // Get GPU
        self.device = MTLCreateSystemDefaultDevice()
        
        // Set clear colors and color format
        self.clearColor = MainViewPreferences.clearColor
        self.colorPixelFormat = MainViewPreferences.pixelFormat
        
        // Init Engine
        Engine.initDefault(device: self.device!)
        
        // Set renderer
        renderer = MainViewRenderer(self)
        
        self.delegate = renderer
        
        // Should only be called once the scene is ready
        SceneManager.initDefault()
        SceneManager.setSence(type: .Basic)
    }
    
    
    // Functions
    
}
