//
//  GameScene.swift
//  Highway Game
//
//  Created by Vadim Shicha on 12/18/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var player: SKSpriteNode!
    
    override func didMove(to view: SKView) {

        //create the background
        let background = SKSpriteNode(color: SKColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), size: CGSize(width: view.bounds.width, height: view.bounds.height))
        background.zPosition = -10 //set the background z-position to be behind everything else
        background.position = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2) //center position the node
        
        self.addChild(background)
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
