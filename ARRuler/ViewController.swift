//
//  ViewController.swift
//  ARRuler
//
//  Created by user161182 on 2/4/20.
//  Copyright © 2020 user161182. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        //
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchLocation = touches.first?.location(in: sceneView){
            
            //.featurePoint detecta a localizacao de um ponto em uma superficie horizontal presente no Scene, se existir.
            let hitTestResults = sceneView.hitTest(touchLocation, types: .featurePoint)
            
            if let hitResult = hitTestResults.first {
                addDot(at: hitResult)
            }
        }
    }
    
    private func addDot(at hitResult: ARHitTestResult) {
        
        // Criando uma esfera
        let dotGeometry =  SCNSphere(radius: 0.005)
        // Criando um material
        let material = SCNMaterial()
        // Definindo o conteudo do material com preenchimento vermelho
        material.diffuse.contents = UIColor.red
        // Inserindo o material na esfera
        dotGeometry.materials = [material]
        
        // Criando um node onde a esfera vai ficar posicionada
        let doteNode = SCNNode(geometry: dotGeometry)
        
        // Pegando as coordenadas do ponto no espaco virtual 3D em que o usuario tocou
        let x_position = hitResult.worldTransform.columns.3.x
        let y_position = hitResult.worldTransform.columns.3.y
        let z_position = hitResult.worldTransform.columns.3.z
        // Definindo a posicao do node no espaco 3D
        doteNode.position = SCNVector3(x_position, y_position, z_position)
        
        // Inserindo o node no espaco 3D(Scene)
        sceneView.scene.rootNode.addChildNode(doteNode)
        
    }
}
