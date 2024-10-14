//
//  ARViewRepresentable.swift
//  mmdb
//
//  Created by Pavithra Sridhar on 5/29/24.
//

import SwiftUI
import RealityKit

struct ARViewRepresentable: UIViewRepresentable {
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        let textAnchor = AnchorEntity()
        textAnchor.addChild(textGen(textString: text))
        arView.scene.addAnchor(textAnchor)
        return arView
    }
    
    func textGen(textString: String) -> ModelEntity {
        
        let materialVar = SimpleMaterial(color: .white, roughness: 0, isMetallic: true)
        
        let depthVar: Float = 0.01
        let fontVar = UIFont.systemFont(ofSize: 0.01)
        let containerFrameVar = CGRect(x: -0.05, y: -0.1, width: 0.1, height: 0.1)
        let alignmentVar: CTTextAlignment = .center
        let lineBreakModeVar : CTLineBreakMode = .byWordWrapping
        
        let textMeshResource : MeshResource = MeshResource.generateText(textString,
                                                                        extrusionDepth: depthVar,
                                                                        font: fontVar,
                                                                        containerFrame: containerFrameVar,
                                                                        alignment: alignmentVar,
                                                                        lineBreakMode: lineBreakModeVar)
        
        let textEntity = ModelEntity(mesh: textMeshResource, materials: [materialVar])
        
        return textEntity
    }
    
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}
