//
//  RayCastingShaderTypes.metal
//  RayCastingEngine
//
//  Created by Nguyễn Đức Quang on 12/13/20.
//

#include <metal_stdlib>

using namespace metal;

// Must match with definitions in Preferences.swift
constant int VERTEX_ATTR_LOCATION = 0;
constant int VERTEX_ATTR_COLOR = 1;

struct VertexIn {
    float3 position [[ attribute(VERTEX_ATTR_LOCATION) ]];
    float4 color [[ attribute(VERTEX_ATTR_COLOR) ]];
};

struct Rasterize {
    float4 position [[ position ]];
    float4 color;
};

struct ModelConstant {
    float4x4 modelMatrix;
};

struct SceneConstant {
    float4x4 viewMatrix;
    float4x4 projectionMatrix;
};
