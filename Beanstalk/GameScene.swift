//
//  GameScene.swift
//  Beanstalk
//
//  Created by Bill Sylva on 5/29/15.
//  Copyright (c) 2015 Bill Sylva. All rights reserved.
//
// To Do:
// Add more buttons for passing levels to MainGame

import SpriteKit


class GameScene: SKScene {
    
    var Level1: SKNode?
    var Level2: SKNode?
    var Level3: SKNode?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        Level1 = childNodeWithName("Level1")
        Level1!.position = CGPoint(x:CGRectGetMidX(self.frame), y:(CGRectGetMidY(self.frame)+100));
        Level2 = childNodeWithName("Level2")
        Level2!.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        Level3 = childNodeWithName("Level3")
        Level3!.position = CGPoint(x:CGRectGetMidX(self.frame), y:(CGRectGetMidY(self.frame)-100));
    }
    func unhighlightButtons () {
        Level1!.xScale = 1.0
        Level1!.yScale = 1.0
        Level2!.xScale = 1.0
        Level2!.yScale = 1.0
        Level3!.xScale = 1.0
        Level3!.yScale = 1.0
    }
    func highlightButton (b: SKNode) {
        b.xScale = 1.1
        b.yScale = 1.1
    }
    
    func checkButtons(touches: Set<NSObject>) {
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            if (Level1!.containsPoint(location)) {
                highlightButton(Level1!)
            }
            if (Level2!.containsPoint(location)) {
                highlightButton(Level1!)
            }
            if (Level3!.containsPoint(location)) {
                highlightButton(Level1!)
            }
            
        }
        
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
            checkButtons(touches)
    }

    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        unhighlightButtons()
        checkButtons(touches)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        unhighlightButtons()
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            if (Level1!.containsPoint(location)) {
                let scene = MainGame(size: self.scene!.size)
                scene.scaleMode = SKSceneScaleMode.AspectFill
                scene.userData = NSMutableDictionary()
                scene.userData!["level"] = 1
                self.scene!.view!.presentScene(scene)
            }
            if (Level2!.containsPoint(location)) {
                let scene = MainGame(size: self.scene!.size)
                scene.scaleMode = SKSceneScaleMode.AspectFill
                scene.userData = NSMutableDictionary()
                scene.userData!["level"] = 2
                self.scene!.view!.presentScene(scene)
            }
            if (Level3!.containsPoint(location)) {
                let scene = MainGame(size: self.scene!.size)
                scene.scaleMode = SKSceneScaleMode.AspectFill
                scene.userData = NSMutableDictionary()
                scene.userData!["level"] = 3
                self.scene!.view!.presentScene(scene)
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}


