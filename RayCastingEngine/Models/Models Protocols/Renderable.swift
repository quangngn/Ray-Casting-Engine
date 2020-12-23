//
//  Renderable.swift
//  RayCastingEngine
//
//  Created by Nguyễn Đức Quang on 12/19/20.
//

import MetalKit

protocol Renderable {
    func doRender(renderCmdEncoder: MTLRenderCommandEncoder)
}
