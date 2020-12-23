//
//  RayCastingShader.metal
//  RayCastingEngine
//
//  Created by Nguyễn Đức Quang on 12/13/20.
//

#include <metal_stdlib>
#include "Types/BasicRayCastingShaderTypes.metal"
using namespace metal;

// Must match with definitions in Preferences.swift
// constant int BUFFIDX_VERTEX_BUFFER = 0;
constant int BUFFIDX_MODEL_CONSTANT = 1;
constant int BUFFIDX_SCENE_CONSTANT = 2;

vertex Rasterize basicVertexShader(const VertexIn vertice [[ stage_in ]],
                                        constant ModelConstant &modelConstant [[ buffer(BUFFIDX_MODEL_CONSTANT) ]],
                                        constant SceneConstant &sceneConstant [[ buffer(BUFFIDX_SCENE_CONSTANT) ]]) {
    
    Rasterize output;
    
    output.position = sceneConstant.projectionMatrix * sceneConstant.viewMatrix * modelConstant.modelMatrix * float4(vertice.position, 1);
    output.color = vertice.color;
    
    return output;
}

fragment half4 basicFragmentShader(Rasterize rdOut [[ stage_in]]) {
    float4 color = rdOut.color;
    
    return half4(color[0], color[1], color[2], color[3]);
}


