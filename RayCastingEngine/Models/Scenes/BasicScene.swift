//
//  BasicScene.swift
//  RayCastingEngine
//
//  Created by Nguyễn Đức Quang on 12/20/20.
//

import Foundation

class BasicScene: Scene {
    
    var raysPrevPosition:SIMD3<Float>! = nil
    
    // Constructor
    override init() {
        super.init()
        
        // This will register the default basic camera and set it as current camera
        CameraManager.registerCamera(camera: BasicCamera(), type: .Basic)
        CameraManager.setCamera(type: .Basic)
        
        // add children of this scene
        initScene()
    }
    
    
    // Methods
    func initScene() {
        self.addChild(newNode: Walls(thickness: RayConstant.wallDefaultThickness))
        self.addChild(newNode: Rays(position: SIMD3<Float>(0.5,0.25,0), thickness: RayConstant.rayDefaultThickness))
    }
    
    // update self of each ray only gonna set its model constant matrix, this has to be called last.
    override func update() {
        // a bit tedious, if we change the order in the init sce
        let walls = self.children[0] as! Walls
        let rays = self.children[1] as! Rays
        
        // set the position of each ray
        rays.updateChildrenPosition();

        // update the end points of each ray in rays (must be called before each each ray called updateSelf().
        if (raysPrevPosition == nil || raysPrevPosition != rays.position) {
            // update prev position
            raysPrevPosition = rays.position

            // update the end point pf each ray
            for ray in rays.children {
                let tempStart = (ray as! Ray).start
                (ray as! Ray).end = SIMD3<Float>(tempStart.x + cos(ray.orientation.z) * RayConstant.rayDefaultLength,
                                                 tempStart.y + sin(ray.orientation.z) * RayConstant.rayDefaultLength,
                                                 0)
                var closestIntersection:SIMD3<Float>! = nil

                // check if the current ray intersects with each wall
                for wall in walls.children {
                    // get intersection
                    guard let tempIntersection = Ray.getIntesection(ray1: ray as! Ray, ray2: wall as! Ray) else {
                        continue
                    }

                    // if we have intersection, check if it is the closest one
                    if (closestIntersection == nil) {
                        closestIntersection = tempIntersection
                    } else {
                        let temp = Ray.closerPoint(center: (ray as! Ray).start, original: closestIntersection, candidate: tempIntersection)
                        if (temp != nil) {
                            closestIntersection = temp
                        }
                    }
                    
                    // update the end point
                    if closestIntersection != nil {
                        (ray as! Ray).end = closestIntersection
                    }
                }
            }
        }
        
        // update children (so that each leave node can update its model constant)
        super.update()
    }
    
}
