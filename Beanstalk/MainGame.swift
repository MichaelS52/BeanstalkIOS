//
//  MainGame.swift
//  Beanstalk
//
//  Created by Bill Sylva on 5/30/15.
//  Copyright (c) 2015 Bill Sylva. All rights reserved.
//

import Foundation
import SpriteKit

let MaxDeviation = 10
let MaxHeight = 100
let SectionHeight = 60
let SectionWidth = 40

struct vineStruct {
    var direction: Int
    var sprite: SKSpriteNode
}



class MainGame: SKScene {
    var vineArray: [vineStruct] = []
    var object: SKSpriteNode!
    
    var start = false
    
    func buildVine() {
        var height = 0
        var deviation = MaxDeviation/2;
        let midX = self.size.width/2.0

        for var i = 0; i < MaxHeight; i++ {
            var object = SKSpriteNode(color: UIColor.greenColor(), size: CGSize(width: SectionWidth, height: SectionHeight))
            let currentHeight = CGFloat(SectionHeight * i)
            let r = Int(arc4random_uniform(UInt32(MaxDeviation)))
            if (r < deviation) {
                deviation--;
            }
            if (deviation < 0) {
                deviation = 0
            }
            if (r > deviation) {
                deviation++
            }
            if (deviation > MaxDeviation) {
                deviation = MaxDeviation
            }
            let curX = midX + CGFloat((deviation - MaxDeviation/2) * SectionWidth)
            println ("add block @ \(curX),\(currentHeight)")
            object.position = CGPoint(x: curX, y: currentHeight)
            let newElem = vineStruct(direction: 0, sprite: object)
            vineArray.append(newElem)
            addChild(object)
        }
    }
    
    
    func moveVine() {
        for vine in vineArray {
            vine.sprite.position.y -= 10;
        }
    }
    
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        let x  = self.userData!["level"] as! Int
        
        println("start scene with level \(x)")
        buildVine()
        
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        start = true
    }
    
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
        }
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        if (start) {
            moveVine()
        }
    }
}

