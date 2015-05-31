//
//  GameScene.swift
//  Beanstalk
//
//  Created by Bill Sylva on 5/29/15.
//  Copyright (c) 2015 Bill Sylva. All rights reserved.
//

import SpriteKit


let StartButtonName = "startButton"

class GameScene: SKScene {
    
    var startButton: SKNode?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        startButton = childNodeWithName(StartButtonName)

        startButton!.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
    }
    func resetButtonScale () {
        startButton?.xScale = 1.0
        startButton?.yScale = 1.0
    }
    
    func swoleButton(touches: Set<NSObject>) {
        
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            if (startButton!.containsPoint(location)) {
                startButton?.xScale = 1.1
                startButton?.yScale = 1.1
            }
        }
        
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
            swoleButton(touches)
    }

    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        resetButtonScale()
        swoleButton(touches)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        resetButtonScale()
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            if (startButton!.containsPoint(location)) {
                let scene = MainGame(size: self.scene!.size)
                scene.scaleMode = SKSceneScaleMode.AspectFill
                scene.userData = NSMutableDictionary()
                scene.userData!["level"] = 2
                
                
                
                self.scene!.view!.presentScene(scene)
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}


//  let myLabel = SKLabelNode(fontNamed:"Chalkduster")
//  myLabel.text = "Hello, World!";
//  myLabel.fontSize = 65;
//  myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));

//  self.addChild(myLabel)
//    let sprite = SKSpriteNode(imageNamed:"Spaceship")

//    sprite.xScale = 0.5
//    sprite.yScale = 0.5
//    sprite.position = location

//    let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)

//    sprite.runAction(SKAction.repeatActionForever(action))

//  self.addChild(sprite)
