//
//  FragmentShaderLib.swift
//  RayCastingEngine
//
//  Created by Nguyễn Đức Quang on 12/13/20.
//

import MetalKit

// MARK: - Fragment Shader types
enum FragmentShaderType {
    case Basic
}


// MARK: - Fragment Shader protocol
protocol FragmentShader {
    var name: String { get }
    var functionName: String { get }
    var function: MTLFunction { get }
}


// MARK: - Fragment Shader Library
class FragmentShaderLib {
    
    // Variables
    static var defaultLib: MTLLibrary!
    private static var fragmentShaders: [FragmentShaderType: FragmentShader] = [:]
    
    
    // Functions
    // Must be called after device being set in Engine.swift
    static func initDefault() {
        defaultLib = Engine.device.makeDefaultLibrary()
        
        // init different fragment shaders
        registerFragmentShader(shader: BasicFragmentShader(), type: .Basic)
    }
    
    static func registerFragmentShader(shader: FragmentShader , type: FragmentShaderType) {
        fragmentShaders.updateValue(shader, forKey: type)
    }
    
    static func getFragmentShader(type: FragmentShaderType) -> MTLFunction {
        return fragmentShaders[type]!.function
    }
}


// MARK: - Different types of Fragment Shaders
struct BasicFragmentShader: FragmentShader {
    
    // Variables
    var name: String
    var functionName: String
    var function: MTLFunction
    
    
    // Constructors
    init() {
        name = "Basic Fragment Shader"
        functionName = "basicFragmentShader"
        function = FragmentShaderLib.defaultLib.makeFunction(name: functionName)!
    }
}


