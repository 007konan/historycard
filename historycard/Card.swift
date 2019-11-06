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
    init(_ img:UIImage) {
        super.init()
        let inner_plane = SCNPlane(width: cardsize, height: cardsize)
        inner_plane.firstMaterial?.diffuse.contents = img
        super.geometry = inner_plane
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Card :SCNNode{
    private var isselect :Bool!
    public var image:UIImage!
    init(_ img:UIImage) {
        super.init()
        self.image = img
        isselect = false
        //画像入れるnode
        let inner_node = Imagenode(img)
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
