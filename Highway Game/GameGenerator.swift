//
//  GameGenerator.swift
//  Highway Game
//
//  Created by Vadim Shicha on 12/20/23.
//

import Foundation
import SpriteKit

enum ObstacleType: String {
    case Car = "OrangeCar", Truck = "Truck", Cone = "Cone", Pothole = "Pothole"
}

struct GameObstacle {
    var type: ObstacleType
    var startPosition: CGPoint //used to give initial position when creating a sprite based on this struct
    var node: SKNode
    
    init(type: ObstacleType, startPosition: CGPoint) {
        self.type = type
        self.startPosition = startPosition
        self.node = SKSpriteNode(color: SKColor.red, size: CGSize(width: 0, height: 0)) //create a blank sprite node
    }
}

//this class handles all the main game generation stuff such as the obstacles and biomes
class GameGenerator {
    
    static let instance = GameGenerator() //single reference to this class
    
    //creates a game obstacle based on type, lane number and y-position (convenient when creating lots of obstacles)
    func createGameObstacle(type: ObstacleType, lane: Int, y: CGFloat) -> GameObstacle {
        return GameObstacle(
            type: type,
            startPosition: CGPoint(x: GameTools.instance.getLaneXPositon(laneNumber: lane), y: y)
        )
    }
    
    //generates a chunk of the main games obstacles
    func generateChunk(sceneYPosition: CGFloat) -> [GameObstacle] {
        
        //scenePositionY: CGFloat
        var obstacles: [GameObstacle] = []
        
        let chunkType = Int.random(in: 0...0)
        
        if(chunkType == 0) {
            let holeLaneNumber = Int.random(in: 1...3) //lane number of where there isn't a car
            for i in 0...4 {
                if(i != holeLaneNumber) {
                    let gameObstacle = GameObstacle(
                        type: ObstacleType.Car,
                        startPosition: CGPoint(x: GameTools.instance.getLaneXPositon(laneNumber: i), y: sceneYPosition)
                    )
                    obstacles.append(gameObstacle)
                }
            }
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 4, y: sceneYPosition + 200))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 0, y: sceneYPosition + 250))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 3, y: sceneYPosition + 250))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 0, y: sceneYPosition + 300))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 3, y: sceneYPosition + 300))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 0, y: sceneYPosition + 350))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 3, y: sceneYPosition + 350))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 0, y: sceneYPosition + 400))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 4, y: sceneYPosition + 400))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 1, y: sceneYPosition + 450))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 4, y: sceneYPosition + 450))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 1, y: sceneYPosition + 500))

            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 1, y: sceneYPosition + 550))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 2, y: sceneYPosition + 600))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 2, y: sceneYPosition + 650))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 3, y: sceneYPosition + 700))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 3, y: sceneYPosition + 750))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 3, y: sceneYPosition + 800))
        }
        
        
        return obstacles
    }
}
