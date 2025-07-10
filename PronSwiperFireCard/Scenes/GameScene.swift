import SpriteKit

class GameScene: TSce {
    var _gameState: ConstantConfiguration.GameState = .None
    var _level: Int = UserDefaults.standard.integer(forKey: ConstantConfiguration.level)
    let _screenSize = MyScreenSize.screenSize
    var _startTime: Double = 0
    var _score: Int = 0
    var _totalScore: Int = 0
    var _spaceStationMaxEnergy: Int = 20
    var _boosted: Bool = false
    
    let startPrompt = TLab(text: "Tap to explore", fontSize: 40, fontName: UIFont.familyNames[20], color: UIColor.white, position: .withPercent(50, y: 50), zPosition: ConstantConfiguration.zPosition.layer_5)
    
    var stationEnergyBar = EnergyBar(maxEnergy: 0, position: .withPercent(31, y: 88), zPosition: ConstantConfiguration.zPosition.layer_5)

    var stars = [Star]()
    var asteroids = [Asteroid]()
    var spaceship: Spaceship?
    
    let sprite1 = TSpri(imageNamed: "game_sprite1", size: .withPercentScaled(roundByWidth: 11), position: .withPercent(25, y: 25), zPosition: ConstantConfiguration.zPosition.layer_2)
    
    let sprite2 = TSpri(imageNamed: "game_sprite2", size: .withPercentScaled(roundByWidth: 11), position: .withPercent(75, y: 80), zPosition: ConstantConfiguration.zPosition.layer_2)

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupSpaceBackground()
        setupStationView()
        setupStationControls()
    }
        
    override func update(_ currentTime: TimeInterval) {
        if _gameState != .Play { return }
        
        var deltaTime = CGFloat(currentTime - _startTime)
        if deltaTime > 1.0 {
            deltaTime = 0.1
        }
        _startTime = currentTime
                
        checkSpaceEvents()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            if startPrompt.contains(location) && !startPrompt.isHidden {
                startExploring()
                return
            }
            if _gameState == .Play && !_boosted {
                _boosted = true
                addAlertLabel(txt: "Hyperdrive Activated!", position: .withPercent(50, y: 80), color: .cyan)
                run(.sequence([
                    .wait(forDuration: 3.0),
                    .run {
                        self.addAlertLabel(txt: "Hyperdrive Deactivated!", position: .withPercent(50, y: 78), color: .cyan)
                        self._boosted = false
                    }
                ]))
            }
            if _gameState == .Play, let spaceship = spaceship {
                spaceship.move(to: location)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if _gameState == .Play, let touch = touches.first, let spaceship = spaceship {
            let location = touch.location(in: self)
            spaceship.move(to: location)
        }
    }
}
