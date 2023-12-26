//
//  MainMenuScene.swift
//  Highway Game
//
//  Created by Vadim Shicha on 12/19/23.
//

import Foundation
import SpriteKit
import GameplayKit
import UIKit

class MainMenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        let titleLabel = UILabel()
        titleLabel.frame = Tools.instance.createCenteredRect(
            x: UIScreen.main.bounds.width / 2,
            y: UIScreen.main.bounds.height / 12,
            width: UIScreen.main.bounds.width / 1.2,
            height: UIScreen.main.bounds.height / 10
        )
        titleLabel.text = "Highway Game"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "ChalkboardSE-Bold", size: 45)
        
        
        let freeplayButton = UIButton()
        freeplayButton.frame = Tools.instance.createCenteredRect(
            x: UIScreen.main.bounds.width / 2,
            y: UIScreen.main.bounds.height / 2,
            width: UIScreen.main.bounds.width / 2,
            height: UIScreen.main.bounds.height / 16
        )
        freeplayButton.setTitle("Freeplay", for: .normal)
        freeplayButton.titleLabel?.font = UIFont(name: "ChalkboardSE-Bold", size: 25)
        freeplayButton.layer.cornerRadius = 5
        freeplayButton.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        freeplayButton.addTarget(self, action: #selector(freeplayButtonClicked), for: .touchUpInside)
        
        
        let gameModesButton = UIButton()
        gameModesButton.frame = Tools.instance.createCenteredRect(
            x: UIScreen.main.bounds.width / 2,
            y: (UIScreen.main.bounds.height / 2) + (UIScreen.main.bounds.height / 16) + 10,
            width: UIScreen.main.bounds.width / 2,
            height: UIScreen.main.bounds.height / 16
        )
        gameModesButton.setTitle("Game Modes", for: .normal)
        gameModesButton.titleLabel?.font = UIFont(name: "ChalkboardSE-Bold", size: 25)
        gameModesButton.layer.cornerRadius = 5
        gameModesButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        gameModesButton.addTarget(self, action: #selector(gameModesButtonClicked), for: .touchUpInside)
        
        
        let settingsButton = UIButton()
        settingsButton.frame = Tools.instance.createCenteredRect(
            x: UIScreen.main.bounds.width / 2,
            y: (UIScreen.main.bounds.height / 2) + 2 * ((UIScreen.main.bounds.height / 16) + 10),
            width: UIScreen.main.bounds.width / 2,
            height: UIScreen.main.bounds.height / 16
        )
        settingsButton.setTitle("Settings", for: .normal)
        settingsButton.titleLabel?.font = UIFont(name: "ChalkboardSE-Bold", size: 25)
        settingsButton.layer.cornerRadius = 5
        settingsButton.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        settingsButton.addTarget(self, action: #selector(freeplayButtonClicked), for: .touchUpInside)
        
        
        let aboutButton = UIButton()
        aboutButton.frame = Tools.instance.createCenteredRect(
            x: UIScreen.main.bounds.width / 2,
            y: (UIScreen.main.bounds.height / 2) + 3 * ((UIScreen.main.bounds.height / 16) + 10),
            width: UIScreen.main.bounds.width / 2,
            height: UIScreen.main.bounds.height / 16
        )
        aboutButton.setTitle("About", for: .normal)
        aboutButton.titleLabel?.font = UIFont(name: "ChalkboardSE-Bold", size: 25)
        aboutButton.layer.cornerRadius = 5
        aboutButton.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        aboutButton.addTarget(self, action: #selector(freeplayButtonClicked), for: .touchUpInside)
        
        
        self.view?.addSubview(titleLabel)
        self.view?.addSubview(freeplayButton)
        self.view?.addSubview(gameModesButton)
        self.view?.addSubview(settingsButton)
        self.view?.addSubview(aboutButton)
    }
    
    
    
    @objc func freeplayButtonClicked() {
        GameTools.currentGameMode = GameMode.Freeplay
        GameTools.currentGameLaneAmount = 5
        GameTools.setupGame()
        Tools.instance.changeScenes(fromScene: self, toSceneType: Tools.SceneType.Game)
    }
    
    @objc func gameModesButtonClicked() {
        Tools.instance.changeScenes(fromScene: self, toSceneType: Tools.SceneType.GameModes)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
