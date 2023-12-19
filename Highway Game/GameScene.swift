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
    
    var CAR_WIDTH: CGFloat = 56.0
    var CAR_HEIGHT: CGFloat = 87.5
    
    var ROAD_WIDTH: CGFloat = 0
    var ROAD_HEIGHT: CGFloat = 0
    
    override func didMove(to view: SKView) {
        
        ROAD_WIDTH = view.bounds.width / 7 //road width is 1/7 of screen width
        ROAD_HEIGHT = ROAD_WIDTH / 0.64 //make road-height proportional to road-width
        
        CAR_WIDTH = ROAD_WIDTH / 1.25 //set car width to be smaller than road width
        CAR_HEIGHT = ROAD_HEIGHT / 1.25 //set car height to be smaller than road height

        //create the background node
        let background = SKSpriteNode(color: SKColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), size: CGSize(width: view.bounds.width, height: view.bounds.height))
        background.zPosition = -10 //set the background z-position to be behind everything else
        background.position = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2) //center position the node
        
        self.addChild(background)
        
        //create the player node
        player = SKSpriteNode(imageNamed: "DefaultCar")
        player.size = CGSize(width: CAR_WIDTH, height: CAR_HEIGHT)
        player.position = CGPoint(x: view.bounds.width / 2, y: CAR_HEIGHT)
        
        self.addChild(player)
        
        //generate all the road background nodes
        for y in 0...10 {
            for x in 0...4 {
                //create the road node
                let road = SKSpriteNode(imageNamed: "Road")
                road.size = CGSize(width: ROAD_WIDTH, height: ROAD_HEIGHT)
                road.position = CGPoint(x: (view.bounds.width / 2) + ((CGFloat(x) - 2) * ROAD_WIDTH), y: CGFloat(y) * ROAD_HEIGHT)
                road.zPosition = -1
                self.addChild(road)
            }
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
