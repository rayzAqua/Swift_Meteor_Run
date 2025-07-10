import SpriteKit

extension GameScene {
    func setupSpaceBackground() {
        let space = TSpri(imageNamed: "img_background", size: CGSize.withPercent(100, height: 100), position: MyScreenSize.center(), zPosition: -1)
        addChild(space)
    }
    
    func setupStationControls() {
        scoreLbl.fontSize = 20
        scoreLbl.text = "Energy: \(_score)/\(_totalScore)"
        scoreLbl.color = UIColor.white
        scoreLbl.position = CGPoint.withPercent(50, y: 91)
    }
    
    func setupStationView() {
        addChild([sprite1, sprite2, startPrompt])
        
        initializeStationLogic()
        
        startPrompt.run(.repeatForever(.sequence([
            .fadeAlpha(to: 0.7, duration: 0.5),
            .fadeAlpha(to: 1.0, duration: 0.5)
        ])))
        
        sprite1.run(.repeatForever(.sequence([
            .moveBy(x: 10, y: 10, duration: 0.4),
            .fadeAlpha(to: 0.8, duration: 0.2),
            .moveBy(x: -10, y: -10, duration: 0.4),
            .fadeAlpha(to: 1.0, duration: 0.2)
        ])))
        
        sprite2.run(.repeatForever(.sequence([
            .scaleX(to: 1.2, duration: 0.3),
            .rotate(byAngle: 0.3, duration: 0.3),
            .scaleX(to: 1.0, duration: 0.3),
            .rotate(byAngle: -0.3, duration: 0.3)
        ])))
    }
    
    func initializeStationLogic() {
        _gameState = .Init
        _score = 0
        _totalScore = Int.random(in: 50...200) * _level
    }
    
    func startExploring() {
        startPrompt.removeAllActions()
        startPrompt.removeFromParent()
        startPrompt.isHidden = true
        
        stationEnergyBar.size = .withPercent(40, height: 2)
        stationEnergyBar.getMaxEnergy(_spaceStationMaxEnergy)
        addChild(stationEnergyBar)
        
        scoreLbl.text = "Energy: \(_score)/\(_totalScore)"
        addChild(scoreLbl)
        
        spawnSpaceship()
        spawnStars()
        spawnAsteroids()
        
        _gameState = .Play
    }
    
    func spawnSpaceship() {
        let spaceship = Spaceship(position: .withPercent(50, y: 20), zPosition: 3)
        spaceship.activate()
        addChild(spaceship)
        self.spaceship = spaceship
    }
    
    func spawnStars() {
        run(.repeatForever(.sequence([
            .wait(forDuration: 2.0),
            .run { [self] in
                let posX = CGFloat.random(in: 10...90)
                let posY = CGFloat.random(in: 20...80)
                let star = Star(size: .withPercentScaled(roundByWidth: 8), position: .withPercent(posX, y: posY), zPosition: 3)
                star.activate()
                addChild(star)
                stars.append(star)
            }
        ])))
    }
    
    func spawnAsteroids() {
        run(.repeatForever(.sequence([
            .wait(forDuration: 0.8),
            .run { [self] in
                let random = CGFloat.random(in: 0...1)
                let asteroid: Asteroid
                if random < 0.3 {
                    asteroid = Asteroid(position: .zero, zPosition: 3, type: .large)
                } else if random < 0.6 {
                    asteroid = Asteroid(position: .zero, zPosition: 3, type: .medium)
                } else {
                    asteroid = Asteroid(position: .zero, zPosition: 3, type: .small)
                }
                asteroid.activate()
                addChild(asteroid)
                asteroids.append(asteroid)
            }
        ])))
    }
        
    func updateEnergy(value: Int) {
        _score += value
        if _score < 0 { _score = 0 }
        scoreLbl.text = "Energy: \(_score)/\(_totalScore)"
        checkWin()
    }
    
    func checkWin() {
        if _score >= _totalScore {
            _gameState = .Win
            removeAllActions()
            spaceship?.deactivate()
            for s in stars { s.deactivate() }
            for a in asteroids { a.deactivate() }
            if _level + 1 > UserDefaults.standard.integer(forKey: ConstantConfiguration.bestLevel) {
                UserDefaults.standard.set(_level + 1, forKey: ConstantConfiguration.bestLevel)
            }
            UserDefaults.standard.set(true, forKey: ConstantConfiguration.isWin)
            run(.sequence([
                .wait(forDuration: 1.0),
                .run {
                    NavigationHelper.dismissAllViewControllers()
                    NavigationHelper.presentGameOver()
                    self.view?.presentScene(nil)
                }
            ]))
        }
    }
    
    func damageStation(amount: Int) {
        _spaceStationMaxEnergy -= amount
        stationEnergyBar.updateEnergy(newEnergy: _spaceStationMaxEnergy)
        if _spaceStationMaxEnergy <= 0 {
            endExploring()
        }
    }
    
    func checkSpaceEvents() {
        guard let spaceship = spaceship else { return }
        
        for star in stars where star._active {
            if spaceship.intersects(star) {
                let score = 5
                updateEnergy(value: score)
                star.deactivate()
                star.selfDestruct()
                stars.remove(star)
                break
            }
        }
        
        for asteroid in asteroids where asteroid._active && asteroid._markedForRemoval {
            asteroid.deactivate()
            asteroid.selfDestruct()
            asteroids.remove(asteroid)
            break
        }
        
        for asteroid in asteroids where asteroid._active && !asteroid._markedForRemoval {
            if spaceship.intersects(asteroid) {
                asteroid.deactivate()
                if !_boosted {
                    damageStation(amount: asteroid.getDamage())
                    spaceship.run(.sequence([
                        .fadeAlpha(to: 0.5, duration: 0.1),
                        .fadeAlpha(to: 1.0, duration: 0.1)
                    ]))
                }
                asteroid.run(.fadeAlpha(to: 0.0, duration: 0.15)) { [self] in
                    asteroid.selfDestruct()
                    asteroids.remove(asteroid)
                }
                break
            }
        }
    }
    
    func endExploring() {
        _gameState = .End
        UserDefaults.standard.set(false, forKey: ConstantConfiguration.isWin)
        removeAllActions()
        spaceship?.deactivate()
        for s in stars { s.deactivate() }
        for a in asteroids { a.deactivate() }
        spaceship?.deactivate()
        run(.sequence([
            .wait(forDuration: 1.0),
            .run {
                NavigationHelper.dismissAllViewControllers()
                NavigationHelper.presentGameOver()
                self.view?.presentScene(nil)
            }
        ]))
    }
    
    func addAlertLabel(txt: String, position: CGPoint, size: CGFloat = 20.0, color: UIColor = .white) {
        let alert = SKLabelNode(text: txt)
        run(.sequence([
            .run { [self] in
                alert.zPosition = .greatestFiniteMagnitude
                alert.fontSize = size
                alert.fontColor = color
                alert.fontName = UIFont.familyNames[4]
                alert.position = position
                addChild(alert)
            },
            .wait(forDuration: 0.5),
            .run { alert.removeFromParent() }
        ]))
    }
}
