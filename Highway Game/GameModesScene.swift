//
//  GameModesScene.swift
//  Highway Game
//
//  Created by Vadim Shicha on 12/24/23.
//

import Foundation
import SpriteKit
import GameplayKit
import UIKit

class GameModesScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        let titleLabel = UILabel()
        titleLabel.frame = Tools.instance.createCenteredRect(
            x: UIScreen.main.bounds.width / 2,
            y: UIScreen.main.bounds.height / 12,
            width: UIScreen.main.bounds.width / 1.2,
            height: UIScreen.main.bounds.height / 10
        )
        titleLabel.text = "Game modes"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "ChalkboardSE-Bold", size: 45)
        
        
        let tripleLanesButton = UIButton()
        tripleLanesButton.frame = Tools.instance.createCenteredRect(
            x: UIScreen.main.bounds.width / 2,
            y: UIScreen.main.bounds.height / 2,
            width: UIScreen.main.bounds.width / 2,
            height: UIScreen.main.bounds.height / 16
        )
        tripleLanesButton.setTitle("Triple Lanes", for: .normal)
        tripleLanesButton.titleLabel?.font = UIFont(name: "ChalkboardSE-Bold", size: 25)
        tripleLanesButton.layer.cornerRadius = 5
        tripleLanesButton.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        tripleLanesButton.addTarget(self, action: #selector(tripleLanesButtonClicked), for: .touchUpInside)
        
        let stuckInArcticButton = UIButton()
        stuckInArcticButton.frame = Tools.instance.createCenteredRect(
            x: UIScreen.main.bounds.width / 2,
            y: (UIScreen.main.bounds.height / 2) + (UIScreen.main.bounds.height / 16) + 10,
            width: UIScreen.main.bounds.width / 2,
            height: UIScreen.main.bounds.height / 16
        )
        stuckInArcticButton.setTitle("Stuck in Arctic", for: .normal)
        stuckInArcticButton.titleLabel?.font = UIFont(name: "ChalkboardSE-Bold", size: 25)
        stuckInArcticButton.titleLabel?.textAlignment = .center
        stuckInArcticButton.layer.cornerRadius = 5
        stuckInArcticButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        stuckInArcticButton.addTarget(self, action: #selector(returnHomeButtonClicked), for: .touchUpInside)
        
        
        let returnHomeButton = UIButton()
        returnHomeButton.frame = Tools.instance.createCenteredRect(
            x: UIScreen.main.bounds.width / 2,
            y: (UIScreen.main.bounds.height / 2) + 2 * ((UIScreen.main.bounds.height / 16) + 10),
            width: UIScreen.main.bounds.width / 2,
            height: UIScreen.main.bounds.height / 16
        )
        returnHomeButton.setTitle("<- Back", for: .normal)
        returnHomeButton.titleLabel?.font = UIFont(name: "ChalkboardSE-Bold", size: 25)
        returnHomeButton.titleLabel?.textAlignment = .center
        returnHomeButton.layer.cornerRadius = 5
        returnHomeButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        returnHomeButton.addTarget(self, action: #selector(returnHomeButtonClicked), for: .touchUpInside)
        
        
        self.view?.addSubview(titleLabel)
        self.view?.addSubview(tripleLanesButton)
        self.view?.addSubview(stuckInArcticButton)
        self.view?.addSubview(returnHomeButton)
    }
    
    
    
    @objc func returnHomeButtonClicked() {
        Tools.instance.changeScenes(fromScene: self, toSceneType: Tools.SceneType.MainMenu)
    }
    
    @objc func tripleLanesButtonClicked() {
        GameTools.currentGameMode = GameMode.TripleLane
        GameTools.currentGameLaneAmount = 3
        GameTools.setupGame()
        Tools.instance.changeScenes(fromScene: self, toSceneType: Tools.SceneType.Game)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
