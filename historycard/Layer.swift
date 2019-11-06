//
//  Layer.swift
//  historycard
//
//  Created by 藤田一貴 on 2019/11/04.
//  Copyright © 2019 kazuki fujita. All rights reserved.
//


import UIKit
import SceneKit
import ARKit

fileprivate class Layer:SCNNode{
    var number:Int!
    
    
    init(_ number:Int)  {
        super.init()
        super.position  = SCNVector3(0, 0, -0.5 * Double(number) )
        self.number = number
        if islayerhidden{
            super.geometry = SCNPlane(width: layer_size, height: layer_size)
            super.geometry?.firstMaterial?.diffuse.contents = layer_color
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class Layers: SCNNode {
    override init(){
        super.init()
        for i in 0...layer_count {
            let lay = Layer(i)
            super.addChildNode(lay)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addcard(number:Int,card:Card){
        for node in super.childNodes{
            if let layer = node as? Layer{
                if layer.number == number{
                    layer.addChildNode(card)
                }
            }
            
        }
    }
}
