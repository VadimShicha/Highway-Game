//
//  GameScene.swift
//  Highway Game
//
//  Created by Vadim Shicha on 12/18/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player: SKSpriteNode!
    
    var gameObstacles: [GameObstacle] = [] //array of all the loaded game obstacles
    var roadNodes: [[SKSpriteNode]] = [[]]
    
    let playerCategoryMask: UInt32 = 0x1 << 0
    let obstacleCategoryMask: UInt32 = 0x1 << 1
    
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
        
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        //create the player node
        player = SKSpriteNode(imageNamed: "DefaultCar")
        player.size = CGSize(width: GameTools.CAR_WIDTH, height: GameTools.CAR_HEIGHT)
        player.position = CGPoint(x: view.bounds.width / 2, y: GameTools.CAR_HEIGHT)
        player.zPosition = 1 //make the player on a higher z-position than all the obstacles
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.categoryBitMask = playerCategoryMask
        player.physicsBody?.contactTestBitMask = obstacleCategoryMask
        player.physicsBody?.usesPreciseCollisionDetection = true
        self.addChild(player)
        
        //generate all the road background nodes
        for y in 0...15 {
            var roadRowArray: [SKSpriteNode] = []
            
            for x in 0...4 {
                //create the road node
                let road = SKSpriteNode(imageNamed: "Road")
                road.size = CGSize(width: GameTools.ROAD_WIDTH, height: GameTools.ROAD_HEIGHT)
                road.position = CGPoint(x: (view.bounds.width / 2) + ((CGFloat(x) - 2) * GameTools.ROAD_WIDTH), y: (CGFloat(y) - 5) * GameTools.ROAD_HEIGHT)
                road.zPosition = -1
                roadRowArray.append(road)
                self.addChild(road)
            }
            
            roadNodes.append(roadRowArray)
        }
        
        addNewChunk()
    }
    
    var currentChunkIndex: Int = 0 //chunk index of the current chunk that is coming or on screen
    
    //generates and adds the new chunk to the view
    func addNewChunk() {
        var generatedObstacles = GameGenerator.instance.generateChunk(sceneYPosition: 2500) //generate a chunk of obstacles
        
        //loop through all the generated objects to create nodes for each one
        for i in 0..<generatedObstacles.count {
            //create obstacle node
            let obstacleNode = SKSpriteNode(imageNamed: generatedObstacles[i].type.rawValue)
            obstacleNode.size = GameTools.instance.getObstacleSize(type: generatedObstacles[i].type)
            obstacleNode.position = generatedObstacles[i].startPosition
            obstacleNode.physicsBody = SKPhysicsBody(rectangleOf: obstacleNode.size)
            obstacleNode.physicsBody?.categoryBitMask = obstacleCategoryMask
            obstacleNode.physicsBody?.contactTestBitMask = playerCategoryMask
            
            generatedObstacles[i].node = obstacleNode //save the node to the game object
            generatedObstacles[i].chunkIndex = currentChunkIndex //set the chunk index (used to figure which chunk is being removed)
            self.addChild(obstacleNode)
        }
        
        gameObstacles = gameObstacles + generatedObstacles //combine the old obstacles with the new ones
        currentChunkIndex += 1
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //check if the player is colliding with an obstacle
        if((contact.bodyA.categoryBitMask == playerCategoryMask && contact.bodyB.categoryBitMask == obstacleCategoryMask) ||
           (contact.bodyA.categoryBitMask == obstacleCategoryMask && contact.bodyB.categoryBitMask == playerCategoryMask)) {
            print("You lost")
        }
    }
    
    //called when the home button is clicked
    @objc func homeButtonClicked() {
        Tools.instance.changeScenes(fromScene: self, toSceneType: Tools.SceneType.MainMenu)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //loop through all the touches that moved
        for touch in touches {
            let location = touch.location(in: self) //get location of the touch
            
            //check if the touch's y-position is in range of the lower part of the screen
            if(location.y < UIScreen.main.bounds.height / 2) {
                player.position.x = location.x
            }
        }
    }
    
    var roadYOffset: CGFloat = 0 //offset added to road nodes y-positions
    var lastUpdateTime: TimeInterval = -1 //keeps track of when the last update frame occurred
    
    //called before a frame is rendered
    override func update(_ currentTime: TimeInterval) {
        //for the first update frame, initialize the last update variable
        if(lastUpdateTime == -1) {
            lastUpdateTime = currentTime
        }
        
        //the time that elapsed between this and the last update frame (useful when creating time based logic that should be the same on all device speeds)
        let timeBetweenFrames = currentTime - lastUpdateTime
        
        gameObstacles = gameObstacles.filter({$0.type != ObstacleType.Empty}) //remove any empty objects in the array
        
        //loop through all the game obstacles and update the y-position
        for i in 0..<gameObstacles.count {
            gameObstacles[i].node.position.y -= GameTools.currentGameSpeed * CGFloat(timeBetweenFrames) * 100 //move the obstacle down the scene
            
            //check all the objects that fall beneath the screen view
            if(gameObstacles[i].node.position.y < -UIScreen.main.bounds.height / 2) {
                gameObstacles[i].node.removeFromParent() //remove the node from the scene
                
                //if the last chunk's first object got deleted, spawn the next chunk
                if(gameObstacles[i].chunkIndex + 1 == currentChunkIndex) {
                    addNewChunk()
                }
                
                gameObstacles[i].type = ObstacleType.Empty //set the obstacle type to Empty so the next frame it will be removed
            }
        }
        
        roadYOffset -= GameTools.currentGameSpeed * CGFloat(timeBetweenFrames) * 100 //make the road offsets be in sync with the moving obstacles
        
        //if the road offset is atleast a road-width then add a road height (makes the road nodes loop back seamlessly)
        if(roadYOffset <= -GameTools.ROAD_HEIGHT) {
            roadYOffset += GameTools.ROAD_HEIGHT
        }
        
        //update all the road node's y-position offsets
        for row in 0..<roadNodes.count {
            for column in 0..<roadNodes[row].count {
                roadNodes[row][column].position.y = ((CGFloat(row) - 5) * GameTools.ROAD_HEIGHT) + roadYOffset //same equation used for inital position except offset
            }
        }
        
        lastUpdateTime = currentTime //update the variable for the next update cycle
    }
}
