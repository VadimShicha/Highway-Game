//
//  Tools.swift
//  Highway Game
//
//  Created by Vadim Shicha on 12/19/23.
//

import Foundation
import SpriteKit

class Tools {
    enum SceneType {
        case MainMenu, GameModes, Game
    }
    
    static let instance = Tools() //single reference to this class
    
    
    //get the screen width with a divide fraction
    func screenWidthFraction(_ fraction: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.width / fraction
    }
    
    //get the screen height with a divide fraction
    func screenHeightFraction(_ fraction: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.height / fraction
    }
    
    //creates a CGRect where the x and y positions are based on the rect's center point (instead of aligning from top-left)
    func createCenteredRect(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> CGRect {
        let rect = CGRect(
            x: x - (width / 2),
            y: y - (height / 2),
            width: width,
            height: height
        )
        return rect
    }
    
    func changeScenes(fromScene: SKScene, toSceneType: SceneType) {
        let scene = getScene(sceneType: toSceneType) //get the SKScene from the to-scene-type
        
        scene.scaleMode = .aspectFill //set the scene scale mode
        
        if(fromScene.view != nil) {
            //loop through all subviews in view
            for subView in fromScene.view!.subviews {
                subView.removeFromSuperview() //remove the subview from the view's subviews
            }
        }
        fromScene.view?.presentScene(scene) //present the scene using the currently-renderering scene's view
    }
    
    //get the SKScene using a scene type
    func getScene(sceneType: SceneType) -> SKScene {
        switch sceneType {
            case SceneType.MainMenu:
                return MainMenuScene(size: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
            case SceneType.GameModes:
                return GameModesScene(size: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
            case SceneType.Game:
                return GameScene(size: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        }
    }
}
