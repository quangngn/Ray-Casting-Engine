//
//  VertexShaderLib.swift
//  RayCastingEngine
//
//  Created by Nguyễn Đức Quang on 12/13/20.
//

import MetalKit

// MARK: - Vertex Shader types
enum VertexShaderType {
    case Basic
}


// MARK: - Vertex Shader protocol
protocol VertexShader {
    var name: String { get }
    var functionName: String { get }
    var function: MTLFunction { get }
}


// MARK: - Vertex Shader Library
class VertexShaderLib {
    
    // Variables
    static var defaultLib: MTLLibrary!
    private static var vertexShaders: [VertexShaderType: VertexShader] = [:]
    
    
    // Functions
    // Must be called after device being set in Engine.swift
    static func initDefault() {
        defaultLib = Engine.device.makeDefaultLibrary()
        
        // init different vertex shader
        registerVertexShader(shader: BasicVertexShader(), type: .Basic)
    }
    
    static func registerVertexShader(shader: VertexShader, type: VertexShaderType) {
        vertexShaders.updateValue(shader, forKey: type)
    }
    
    static func getVertexShader(type: VertexShaderType) -> MTLFunction {
        return vertexShaders[type]!.function
    }
}


// MARK: - Different types of Vertex Shaders
struct BasicVertexShader: VertexShader {
    
    // Variables
    var name: String
    var functionName: String
    var function: MTLFunction
    
    
    // Constructors
    init() {
        name = "Basic Vertex Shader"
        functionName = "basicVertexShader"
        function = VertexShaderLib.defaultLib.makeFunction(name: functionName)!
    }
}

