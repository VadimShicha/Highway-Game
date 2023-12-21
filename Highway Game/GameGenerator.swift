//
//  GameGenerator.swift
//  Highway Game
//
//  Created by Vadim Shicha on 12/20/23.
//

import Foundation

enum ObstacleType: String {
    case Car = "OrangeCar", Truck = "Truck", Cone = "Cone", Pothole = "Pothole"
}

struct GameObstacle {
    var type: ObstacleType
    var startPosition: CGPoint //used to give initial position when creating a sprite based on this struct
    
    init(type: ObstacleType, startPosition: CGPoint) {
        self.type = type
        self.startPosition = startPosition
    }
}

//this class handles all the main game generation stuff such as the obstacles and biomes
class GameGenerator {
    
    static let instance = GameGenerator() //single reference to this class
    
    //generates a chunk of the main games obstacles
    func generateChunk() -> [GameObstacle] {
        
        //scenePositionY: CGFloat
        var obstacles: [GameObstacle] = []
        
        for i in 0...4 {
            obstacles.append(GameObstacle(type: ObstacleType.Car, startPosition: CGPoint(x: GameTools.instance.getLaneXPositon(laneNumber: i - 2), y: 1000)))
        }
        return obstacles
    }
}
