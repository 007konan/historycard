//
//  Card.swift
//  historycard
//
//  Created by 藤田一貴 on 2019/11/05.
//  Copyright © 2019 kazuki fujita. All rights reserved.
//

import Foundation
import ARKit
import UIKit
class Imagenode:SCNNode
{
    init(front:UIImage, right:UIImage, left:UIImage) {
        super.init()
        let inner_plane = SCNBox(width: cardsize, height: cardsize, length: cardsize, chamferRadius: 0)
        // 6面、別々のテクスチャを貼る
        let m1 = SCNMaterial()
        let m2 = SCNMaterial()
        let m3 = SCNMaterial()
        let m4 = SCNMaterial()
        let m5 = SCNMaterial()
        let m6 = SCNMaterial()

        m1.diffuse.contents = front
        m2.diffuse.contents = right
        m3.diffuse.contents = UIImage(named: "white.png")
        m4.diffuse.contents = left
        m5.diffuse.contents = UIImage(named: "white.png")
        m6.diffuse.contents = UIImage(named: "white.png")

        inner_plane.materials = [m1, m2, m3, m4, m5, m6]
        super.geometry = inner_plane
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Card :SCNNode{
    private var isselect :Bool!
    public var image:UIImage!
    init(front:UIImage, right:UIImage, left:UIImage) {
        super.init()
        self.image = front
        isselect = false
        //画像入れるnode
        let inner_node = Imagenode(front: front, right: right, left: left)
        inner_node.position = SCNVector3(0, 0, 0.002)
        //枠線用のnode
        let outter_plane = SCNPlane(width: cardsize * 1.04, height: cardsize * 1.04)
        outter_plane.firstMaterial?.diffuse.contents = UIColor.clear
        let outer_node = SCNNode(geometry: outter_plane)
        outer_node.position = SCNVector3(0, 0, 0.001)
       
        super.addChildNode(outer_node)
        super.addChildNode(inner_node)
        
       
        
        
    }
    public func select(){
        isselect = !isselect
        if isselect {
            self.childNodes.first?.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        }
        else{
            self.childNodes.first?.geometry?.firstMaterial?.diffuse.contents = UIColor.clear
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
