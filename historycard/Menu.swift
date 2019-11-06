//
//  Menu.swift
//  historycard
//
//  Created by 藤田一貴 on 2019/11/05.
//  Copyright © 2019 kazuki fujita. All rights reserved.
//

import Foundation
import UIKit

class myMenu:UIView{
    private var card:Card!
    private var imageView:UIImageView!
    private var button2:UIButton!
    init() {
        super.init(frame:menuViewsize)
        imageView = UIImageView(frame: CGRect(x:menuViewsize.width * 0.03 , y:menuViewsize.width * 0.03 , width: menuViewsize.width * 0.94, height: menuViewsize.width * 0.94))
        let button1:UIButton = {
            let button = UIButton(frame: CGRect(x:menuViewsize.width * 0.03 , y:menuViewsize.width * 0.97 + 10 , width: menuViewsize.width * 0.94, height: (menuViewsize.height - menuViewsize.width * 0.94 - 40)/4 ))
            button.setTitle("編集", for: .normal)
            button.backgroundColor = .lightGray
            button.addTarget(self, action: #selector(tap1), for: .touchDown)
            return button
        }()
         button2 = {
            let button = UIButton(frame: CGRect(x:menuViewsize.width * 0.03 , y:menuViewsize.width * 0.97 +  (menuViewsize.height - menuViewsize.width * 0.94 - 40)/4 + 20, width: menuViewsize.width * 0.94, height: (menuViewsize.height - menuViewsize.width * 0.94 - 40)/4 ))
            button.setTitle("移動", for: .normal)
            button.backgroundColor = .lightGray
            button.addTarget(self, action: #selector(tap2), for: .touchDown)
            return button
        }()
        let button3:UIButton = {
            let button = UIButton(frame: CGRect(x:menuViewsize.width * 0.03 , y:menuViewsize.width * 0.97 +  (menuViewsize.height - menuViewsize.width * 0.94 - 40)/4 * 2 + 30 , width: menuViewsize.width * 0.94, height: (menuViewsize.height - menuViewsize.width * 0.94 - 40)/4 ))
            button.setTitle("削除", for: .normal)
            button.backgroundColor = .lightGray
            button.addTarget(self, action: #selector(tap3), for: .touchDown)
            return button
        }()
        
        let button4:UIButton = {
            let button = UIButton(frame: CGRect(x:menuViewsize.width * 0.35 , y:menuViewsize.height - 40 , width: menuViewsize.width * 0.30, height: menuViewsize.width * 0.10 ))
            button.setTitle("cancel", for: .normal)
            button.backgroundColor = .lightGray
            button.addTarget(self, action: #selector(tap4), for: .touchDown)
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.cornerRadius = 5.0
            return button
        }()
        
        self.addSubview(button1)
        self.addSubview(button2)
        self.addSubview(button3)
        self.addSubview(button4)
        
        self.addSubview(imageView)
        
        self.backgroundColor = .systemGray
        
        
        
    }
    @objc func tap1(){
        print("tap")
        isswip = false
        isbutton2()
    }
    
    @objc func tap2(_ sender:UIButton){
        isswip = !isswip
        isbutton2()
    }
    @objc func tap3(){
        self.isHidden = true
        card.removeFromParentNode()
        isswip = false
    }
    @objc func tap4(){
        self.isHidden = true
        isswip = false
        isbutton2()
        
    }
    public func setCard(_ card :Card){
        self.card = card
        imageView.image = card.image
        isswip = false
        isbutton2()
    }
    
    private func isbutton2(){
        if isswip{
            button2.layer.borderColor = UIColor.red.cgColor
            button2.layer.borderWidth = 2
        }
        else{
            button2.layer.borderWidth = 0
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
