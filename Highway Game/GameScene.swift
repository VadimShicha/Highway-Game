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
    
    var gameObstacles: [GameObstacle] = []
    
    override func didMove(to view: SKView) {
        
        //create the background node
        let background = SKSpriteNode(color: SKColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), size: CGSize(width: view.bounds.width, height: view.bounds.height))
        background.zPosition = -10 //set the background z-position to be behind everything else
        background.position = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2) //center position the node
        self.addChild(background)
        
        //create the home button
        let homeButton = UIButton()
        homeButton.frame = CGRect(
            x: 10,
            y: 10,
            width: UIScreen.main.bounds.width / 8,
            height: UIScreen.main.bounds.width / 8
        )
        homeButton.setTitle("<", for: .normal)
        homeButton.backgroundColor = .brown
        homeButton.titleLabel?.font = UIFont(name: "ChalkboardSE-Bold", size: 28)
        homeButton.layer.cornerRadius = 5
        homeButton.addTarget(self, action: #selector(homeButtonClicked), for: .touchUpInside)
        self.view?.addSubview(homeButton)
        
        
        //create the player node
        player = SKSpriteNode(imageNamed: "DefaultCar")
        player.size = CGSize(width: GameTools.CAR_WIDTH, height: GameTools.CAR_HEIGHT)
        player.position = CGPoint(x: view.bounds.width / 2, y: GameTools.CAR_HEIGHT)
        player.zPosition = 1 //make the player on a higher z-position than all the obstacles
        self.addChild(player)
        
        //generate all the road background nodes
        for y in 0...10 {
            for x in 0...4 {
                //create the road node
                let road = SKSpriteNode(imageNamed: "Road")
                road.size = CGSize(width: GameTools.ROAD_WIDTH, height: GameTools.ROAD_HEIGHT)
                road.position = CGPoint(x: (view.bounds.width / 2) + ((CGFloat(x) - 2) * GameTools.ROAD_WIDTH), y: CGFloat(y) * GameTools.ROAD_HEIGHT)
                road.zPosition = -1
                self.addChild(road)
            }
        }
        
        let generatedObstacles = GameGenerator.instance.generateChunk() //generate a chunk of obstacles
        
        gameObstacles = gameObstacles + generatedObstacles //combine the old obstacles with the new ones
        
        for i in 0..<generatedObstacles.count {
            let obstacle = SKSpriteNode(imageNamed: generatedObstacles[i].type.rawValue)
            obstacle.size = GameTools.instance.getObstacleSize(type: generatedObstacles[i].type)
            obstacle.position = generatedObstacles[i].startPosition
            
            obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size)
            //obstacle.physicsBody?.mass =
            self.addChild(obstacle)
        }
    }
    
    @objc func homeButtonClicked() {
        Tools.instance.changeScenes(fromScene: self, toSceneType: Tools.SceneType.MainMenu)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
