import SpriteKit

class LevelScene: TSce {
    // MARK: - Properties
    private var levelNodes = [LevelNode]()
    private let columnCount = Int.random(in: 4...6)
    private let rowCount = Int.random(in: 7...9)
    private let padding: CGFloat = 15
    private let screenSize = UIScreen.main.bounds.size
        
    private let sprite1 = TSpri(imageNamed: "lv_sprite1", size: .withPercentScaled(roundByWidth: 11), position: .withPercent(10, y: 10), zPosition: 2)
    private let sprite2 = TSpri(imageNamed: "lv_sprite2", size: .withPercentScaled(roundByWidth: 11), position: .withPercent(90, y: 90), zPosition: 2)
    
    // MARK: - Lifecycle
    override func didMove(to view: SKView) {
        setupBackground()
        setupAnimatedSprites()
        createLevels()
    }
    
    // MARK: - Setup
    private func setupBackground() {
        addChild(genericBackground)
    }
    
    private func setupAnimatedSprites() {
        addChild([sprite1, sprite2])
        
        sprite1.run(.repeatForever(.sequence([
            .run { [self] in
                let posX = CGFloat.random(in: screenSize.width * 0.1...screenSize.width * 0.9)
                let posY = CGFloat.random(in: screenSize.height * 0.1...screenSize.height * 0.8)
                let moveTo: CGPoint = CGPoint(x: posX, y: posY)
                self.sprite1.run(.move(to: moveTo, duration: 2))
            },
            .wait(forDuration: 2)
        ])))
        
        sprite2.run(.repeatForever(.sequence([
            .run { [self] in
                let posX = CGFloat.random(in: screenSize.width * 0.1...screenSize.width * 0.9)
                let posY = CGFloat.random(in: screenSize.height * 0.1...screenSize.height * 0.8)
                let moveTo: CGPoint = CGPoint(x: posX, y: posY)
                self.sprite2.run(.move(to: moveTo, duration: 2))
            },
            .wait(forDuration: 2)
        ])))
    }
    
    private func createLevels() {
        let cellWidth = 0.65 * screenSize.width / CGFloat(columnCount)
        let cellHeight = 0.65 * screenSize.height / CGFloat(rowCount)
        let cellSize = min(cellWidth, cellHeight)
        let currentLevel = UserDefaults.standard.integer(forKey: ConstantConfiguration.bestLevel)
        
        for level in 1...(columnCount * rowCount) {
            let levelNode = LevelNode()
            levelNode.zPosition = 3
            levelNode.setLevelSize(CGSize(width: cellSize, height: cellSize))
            
            let isUnlocked = level == 1 || level <= currentLevel
            if isUnlocked {
                levelNode.setUnlocked()
                levelNode.setLevel(level)
            } else {
                levelNode.setLocked()
            }
            
            levelNodes.append(levelNode)
            addChild(levelNode)
        }
        
        ViewHelper.alignItemsRowsAndCols(
            padding: padding,
            rows: rowCount,
            cols: columnCount,
            items: levelNodes,
            position: .withPercent(50, y: 50)
        )
    }
    
    // MARK: - Touch Handling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchLocation = touches.first?.location(in: self),
              let touchedNode = levelNodes.first(where: { $0.contains(touchLocation) }) else {
            return
        }
        if !touchedNode.isUnlocked() {
            touchedNode.run(.sequence([
                .colorize(with: .gray, colorBlendFactor: 1.0, duration: 0.25),
                .colorize(with: .white, colorBlendFactor: 1.0, duration: 0.25),
            ]))
        } else {
            touchedNode.run(.scale(to: 0.85, duration: 0.25))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchLocation = touches.first?.location(in: self),
              let tappedLevel = levelNodes.first(where: { $0.contains(touchLocation) }),
              let levelIndex = levelNodes.firstIndex(of: tappedLevel) else {
            return
        }
        
        if !tappedLevel.isUnlocked() { return }
        
        let selectedLevel = levelIndex + 1
        UserDefaults.standard.set(selectedLevel, forKey: ConstantConfiguration.level)
//        NavigationHelper.dismissAllViewControllers()
        NavigationHelper.presentGame()
    }
}
