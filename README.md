# Ray-Casting-Engine
A graphic engine that does 2D ray casting using Swift's MetalKit and MetalView.   

![Ray casting demo](ray-casting-demo.gif)

# Files structure  
- Core: contains constants, singleton objects, core types, and libraries for Metal Render Pipeline
  - Core/Lib: libraries for Metal Render Pipeline (Including MathLib.swift).
  - Core/Utilities: constants and some extensions for utilities.
  - Core/CoreEngine.swift: set up the engine by initializing singletons object.
  - Core/CoreTypes.swift: definition of class such as Vertex, ModelConstants (with transformation matrix for each object), and SceneConstants (with projection matrix and camera's view matrix). These classes will have their own definition in Metal.
- View: contains MetalView and its delegate that handles draw calls.
- Metal Shaders: contains GPU code for rendering.
- Models: models of objects being rendered. Node.swift has the definition of Node class. Each item in the scene graph extends from this class. The Ray (aka line) definition is defined in Ray.swift. There are two main items in this 2D Ray Casting Engine: Walls.swift and Rays.swift. To handle projection and avoid distortion due to screen ratio, each scene will also have a camera with a projection matrix.

# To dos
- Move finding rays intersection to GPU?
- Add mouse input support.
