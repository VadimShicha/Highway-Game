//
//  GameGenerator.swift
//  Highway Game
//
//  Created by Vadim Shicha on 12/20/23.
//

import Foundation
import SpriteKit

enum ObstacleType: String {
    case Empty = "Empty", Car = "OrangeCar", Truck = "Truck", Cone = "Cone", Pothole = "Pothole"
}

struct GameObstacle {
    var type: ObstacleType
    var startPosition: CGPoint //used to give initial position when creating a sprite based on this struct
    var node: SKNode
    var chunkIndex: Int
    
    init(type: ObstacleType, startPosition: CGPoint) {
        self.type = type
        self.startPosition = startPosition
        self.node = SKSpriteNode(color: SKColor.red, size: CGSize(width: 0, height: 0)) //create a blank sprite node
        self.chunkIndex = -1
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
    
    //creates a row of cars. the hole is based on the start
    func createCarRow(laneAmount: Int = 5, startLane: Int, endLane: Int, holeAmount: Int, yPosition: CGFloat) -> [GameObstacle] {
        var obstacles: [GameObstacle] = []
        var totalHoles = holeAmount //create a seperate variable incase the number of holes needs to be changed
        
        //check to make sure there isn't more holes than lanes
        if(holeAmount > endLane - startLane) {
            print("Hole amount is greater than the lane amount")
            totalHoles = laneAmount
        }
        
        let holeLaneNumber = Int.random(in: startLane...(endLane - totalHoles)) //lane number of where there isn't a car
        
        for i in 0..<laneAmount {
            
            if(i >= holeLaneNumber && i <= holeLaneNumber + holeAmount - 1) {
                continue
            }
                
            let gameObstacle = GameObstacle(
                type: ObstacleType.Car,
                startPosition: CGPoint(x: GameTools.instance.getLaneXPositon(laneNumber: i), y: yPosition)
            )
            obstacles.append(gameObstacle)
        }
        
        return obstacles
    }
    
    //generates a chunk of the main games obstacles
    func generateChunk(sceneYPosition: CGFloat) -> (obstacles: [GameObstacle], chunkSize: Int) {
        
        var obstacles: [GameObstacle] = []
        var chunkSize = 1000 //this variable needs to be set to the size of the chunk
        
        let chunkType = Int.random(in: 0...3)
        
        if(chunkType == 0) {
            
            chunkSize = 2500
            
            obstacles += createCarRow(startLane: 1, endLane: 3, holeAmount: 1, yPosition: sceneYPosition)
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 4, y: sceneYPosition + 200))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 0, y: sceneYPosition + 250))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 3, y: sceneYPosition + 250))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 0, y: sceneYPosition + 300))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 3, y: sceneYPosition + 300))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 0, y: sceneYPosition + 350))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 3, y: sceneYPosition + 350))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 0, y: sceneYPosition + 400))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 4, y: sceneYPosition + 400))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 0, y: sceneYPosition + 450))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 4, y: sceneYPosition + 450))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 1, y: sceneYPosition + 500))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 4, y: sceneYPosition + 500))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 1, y: sceneYPosition + 550))

            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 1, y: sceneYPosition + 600))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 1, y: sceneYPosition + 650))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 1, y: sceneYPosition + 700))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 2, y: sceneYPosition + 750))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 2, y: sceneYPosition + 800))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 3, y: sceneYPosition + 850))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 3, y: sceneYPosition + 900))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 3, y: sceneYPosition + 950))
            
            obstacles += createCarRow(startLane: 1, endLane: 3, holeAmount: 2, yPosition: sceneYPosition + 1200)
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 0, y: sceneYPosition + 1500))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 4, y: sceneYPosition + 1550))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 1, y: sceneYPosition + 1550))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 4, y: sceneYPosition + 1600))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 1, y: sceneYPosition + 1600))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 4, y: sceneYPosition + 1650))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 1, y: sceneYPosition + 1650))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 4, y: sceneYPosition + 1700))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 0, y: sceneYPosition + 1700))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 4, y: sceneYPosition + 1750))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 0, y: sceneYPosition + 1750))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 4, y: sceneYPosition + 1800))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 0, y: sceneYPosition + 1800))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 3, y: sceneYPosition + 1850))

            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 3, y: sceneYPosition + 1900))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 2, y: sceneYPosition + 1950))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 2, y: sceneYPosition + 2000))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 1, y: sceneYPosition + 2050))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 1, y: sceneYPosition + 2100))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 1, y: sceneYPosition + 2150))
        }
        else if(chunkType == 1) {
            chunkSize = 2500
            
            obstacles += createCarRow(startLane: 1, endLane: 3, holeAmount: 1, yPosition: sceneYPosition)
            
            obstacles += createCarRow(startLane: 1, endLane: 3, holeAmount: 2, yPosition: sceneYPosition + 300)
            
            obstacles += createCarRow(startLane: 1, endLane: 3, holeAmount: 2, yPosition: sceneYPosition + 600)
            
            obstacles += createCarRow(startLane: 1, endLane: 3, holeAmount: 2, yPosition: sceneYPosition + 900)
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 0, y: sceneYPosition + 1200))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 4, y: sceneYPosition + 1200))
            
            obstacles += createCarRow(startLane: 0, endLane: 4, holeAmount: 2, yPosition: sceneYPosition + 1500)
            
            obstacles += createCarRow(startLane: 0, endLane: 4, holeAmount: 2, yPosition: sceneYPosition + 1800)
            
            obstacles += createCarRow(startLane: 0, endLane: 4, holeAmount: 2, yPosition: sceneYPosition + 2100)
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 0, y: sceneYPosition + 2400))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 4, y: sceneYPosition + 2400))
        }
        else if(chunkType == 2) {
            chunkSize = 1000
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 0, y: sceneYPosition))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 4, y: sceneYPosition))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 0, y: sceneYPosition + 300))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 1, y: sceneYPosition + 300))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 4, y: sceneYPosition + 300))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 2, y: sceneYPosition + 600))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 3, y: sceneYPosition + 600))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 4, y: sceneYPosition + 600))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 0, y: sceneYPosition + 900))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 3, y: sceneYPosition + 900))
            obstacles.append(createGameObstacle(type: ObstacleType.Cone, lane: 4, y: sceneYPosition + 900))
        }
        else if(chunkType == 3) {
            chunkSize = 1400
            
            obstacles.append(createGameObstacle(type: ObstacleType.Truck, lane: 0, y: sceneYPosition))
            obstacles.append(createGameObstacle(type: ObstacleType.Truck, lane: 4, y: sceneYPosition))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Truck, lane: 0, y: sceneYPosition + 400))
            obstacles.append(createGameObstacle(type: ObstacleType.Truck, lane: 1, y: sceneYPosition + 400))
            obstacles.append(createGameObstacle(type: ObstacleType.Truck, lane: 4, y: sceneYPosition + 400))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Truck, lane: 2, y: sceneYPosition + 800))
            obstacles.append(createGameObstacle(type: ObstacleType.Truck, lane: 3, y: sceneYPosition + 800))
            obstacles.append(createGameObstacle(type: ObstacleType.Truck, lane: 4, y: sceneYPosition + 800))
            
            obstacles.append(createGameObstacle(type: ObstacleType.Truck, lane: 0, y: sceneYPosition + 1200))
            obstacles.append(createGameObstacle(type: ObstacleType.Truck, lane: 3, y: sceneYPosition + 1200))
            obstacles.append(createGameObstacle(type: ObstacleType.Truck, lane: 4, y: sceneYPosition + 1200))
        }
        
        //chunkSize = 10000
        
        //for i in 0...20 {
        //    obstacles += createCarRow(startLane: 1, endLane: 3, holeAmount: 2, yPosition: sceneYPosition + CGFloat(i * 500))
        //}
        
        return (obstacles: obstacles, chunkSize: chunkSize)
    }
}
