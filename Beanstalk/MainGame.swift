//
//  MainGame.swift
//  Beanstalk
//
//  Created by Bill Sylva on 5/30/15.
//  Copyright (c) 2015 Bill Sylva. All rights reserved.
//
//
// To Do:
//
// Add swipe to jack
// In movevine(), check character intersects any block
// Handle levels in buildvine() and movevine()

import Foundation
import SpriteKit

let MaxDeviation = 8
let MaxHeight = 100
let SectionHeight = 100
let SectionWidth = 60
let straightDelay = 7

struct vineStruct {
    var deviation : Int
    var sprite: SKSpriteNode
}

enum BodyType:UInt32 {
    
    case vine = 1;
    case jack = 2;
    case background = 4;
    
}


class MainGame: SKScene {
    var vineArray: [vineStruct] = []
    var object: SKSpriteNode!
    
    var start = false
    var straightCount = straightDelay;
    var jack: SKSpriteNode!
    
    func swipedRight(sender:UISwipeGestureRecognizer){
        moveRight()
    }
    
    func swipedLeft(sender:UISwipeGestureRecognizer){
        moveLeft()
    }
    
    func swipedUp(sender:UISwipeGestureRecognizer){
        println("swiped up")
    }
    
    func swipedDown(sender:UISwipeGestureRecognizer){
        println("swiped down")
    }
    
    func moveLeft() {
        if(start==true) {
        jack.position.x -= CGFloat(SectionWidth);
        }
    }
    
    
    func moveRight() {
        if(start==true) {
        jack.position.x += CGFloat(SectionWidth);
        }
    }
    
    

    func buildVine() {
        var height = 0
        var deviation = MaxDeviation/2;
        let midX = self.size.width/2.0

        for var i = 0; i < MaxHeight; i++ {
            var object : SKSpriteNode = SKSpriteNode(color: UIColor.greenColor(), size: CGSize(width: SectionWidth, height: SectionHeight))
            let currentHeight = CGFloat(SectionHeight * i)
            straightCount--;
            if (straightCount == 0) {
                let r = Int(arc4random_uniform(UInt32(MaxDeviation)))
                let oldDev = deviation;
            
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
                if oldDev != deviation {
                var WideObject = SKSpriteNode(color: UIColor.greenColor(), size: CGSize(width: SectionWidth, height: SectionHeight))
                    let curX = midX + CGFloat((oldDev - MaxDeviation/2) * SectionWidth)
                    WideObject.position = CGPoint(x: curX, y:currentHeight)
                    let newElem = vineStruct(deviation: oldDev, sprite: WideObject)
                    vineArray.append(newElem)
                    addChild(WideObject)
                }
                straightCount = straightDelay;
            }

            let curX = midX + CGFloat((deviation - MaxDeviation/2) * SectionWidth)
            // println ("add block @ \(curX),\(currentHeight)")
            object.position = CGPoint(x: curX, y: currentHeight)
            let newElem = vineStruct(deviation: deviation, sprite: object)
            vineArray.append(newElem)
            addChild(object)
        }
    }
    
    
    func moveVine() {
        
        var dead : Bool = true;
        var point : CGPoint = jack.position;
        
        
        for vine in vineArray {
            
            if(vine.sprite.containsPoint(point)){
                dead=false;
            }
          
            vine.sprite.position.y -= 8;
        }
        
        if(dead==true) {
            die();
        }
    }
    
    func die() {
        
        var amount : Int = vineArray.count
        println("amount = \(amount)")
        var sceneheight = UIScreen.mainScreen().bounds.height
        println("height = \(sceneheight)")
        
        println("Scene Height: \(sceneheight)")
        
        var vineHeight : CGFloat = vineArray.first!.sprite.size.height;
        println("vine height = \(vineHeight)")
        var totalVines : CGFloat = vineHeight * CGFloat(amount);
        
         println("Total vines: \(amount)")
        println("Total: \(vineHeight)")
        
        var scaleAmount : CGFloat = sceneheight / totalVines
        
        println("Scale: \(scaleAmount)");
        
        start = false;
        let midX = self.size.width/2.0
        var height:CGFloat = 0

        //Last loop through vines
        for vine in vineArray {
            
            if(vine.sprite != vineArray.first?.sprite) {
            
            vine.sprite.xScale = scaleAmount
            vine.sprite.yScale = scaleAmount
                
            var addAmount : CGFloat = vine.sprite.size.height
            vine.sprite.position.y = height
            height += vine.sprite.size.height
                
            let curX = midX + (CGFloat(vine.deviation) * vine.sprite.size.width)
            vine.sprite.position.x = curX
                
            }
        }
        
        start = false;
        let scene = GameScene(fileNamed: "GameScene.swift")
        view?.presentScene(scene)
    }
    
    
    
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        let x  = self.userData!["level"] as! Int
        
        println("start scene with level \(x)")
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedRight:"))
        swipeRight.direction = .Right
        view.addGestureRecognizer(swipeRight)
        
        
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedLeft:"))
        swipeLeft.direction = .Left
        view.addGestureRecognizer(swipeLeft)
        
        
        let swipeUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedUp:"))
        swipeUp.direction = .Up
        view.addGestureRecognizer(swipeUp)
        
        
        let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedDown:"))
        swipeDown.direction = .Down
        view.addGestureRecognizer(swipeDown)
        
        buildVine()

        jack = SKSpriteNode(color: UIColor.blackColor(), size: CGSize(width: 20, height: 20))
        jack.position = CGPoint(x: self.size.width/2.0, y: 100)
        addChild(jack)
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

