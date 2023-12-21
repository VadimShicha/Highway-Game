//
//  GameTools.swift
//  Highway Game
//
//  Created by Vadim Shicha on 12/20/23.
//

import Foundation
import SpriteKit

class GameTools {
    static let instance = GameTools() //single reference to this class
    
    static var ROAD_WIDTH: CGFloat = UIScreen.main.bounds.width / 7 //road width is 1/7 of screen width
    static var ROAD_HEIGHT: CGFloat = ROAD_WIDTH / 0.64 //make road-height proportional to road-width
    
    static var CAR_WIDTH: CGFloat = ROAD_WIDTH / 1.25 //set car width to be smaller than road width (Default: 56.0)
    static var CAR_HEIGHT: CGFloat = ROAD_HEIGHT / 1.25 //set car height to be smaller than road height (Default: 87.5)
    
    //gets the scene x-position by using the lane number (note: lane number 0 is the center lane)
    func getLaneXPositon(laneNumber: Int) -> CGFloat {
        let screenCenterX = UIScreen.main.bounds.width / 2 //the center x-position of the screen
        return screenCenterX + (CGFloat(laneNumber) * GameTools.ROAD_WIDTH)
    }
    
    //gives the size for an obstacle (proportional to the screen size)
    func getObstacleSize(type: ObstacleType) -> CGSize {
        switch type {
            case ObstacleType.Car:
                return CGSize(width: GameTools.CAR_WIDTH, height: GameTools.CAR_HEIGHT)
            case ObstacleType.Cone:
                return CGSize(width: GameTools.CAR_WIDTH, height: GameTools.CAR_WIDTH)
            case ObstacleType.Pothole:
                return CGSize(width: GameTools.CAR_WIDTH / 1.5, height: GameTools.CAR_HEIGHT / 1.5)
            default:
                return CGSize(width: GameTools.CAR_WIDTH, height: GameTools.CAR_HEIGHT)
        }
    }
}