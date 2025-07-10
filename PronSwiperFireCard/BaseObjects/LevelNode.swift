import Foundation
import SpriteKit

class LevelNode: TSpri {
    private let levelLabel = SKLabelNode()
    private var levelNumber: Int = 1
    private var unlocked: Bool = false
    private var fontSizePercentage: CGFloat = 0.6
    private let screenSize = UIScreen.main.bounds.size
    
    private enum LevelState: String {
        case locked = "level_locked"
        case unlocked = "level_unlocked"
    }

    
    override init() {
        let nodeSize = CGSize(width: screenSize.height/10, height: screenSize.height/10)
        super.init(imageNamed: LevelState.locked.rawValue, size: nodeSize, position: .zero, zPosition: .zero)
        setupLabelDefault()
        startPulseAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabelDefault() {
        levelLabel.fontName = ConstantConfiguration.levelLabelFont
        levelLabel.fontColor = .black
        levelLabel.zPosition = 10
        updateLabelFontSizeAndPosition()
        addChild(levelLabel)
    }
    
    private func updateLabelFontSizeAndPosition() {
        let referenceSize = min(size.width, size.height)
        levelLabel.fontSize = referenceSize * fontSizePercentage
        levelLabel.position = CGPoint(x: 0, y: -referenceSize * 0.2)
    }
    
    private func startPulseAnimation() {
        let scaleUp = SKAction.scale(to: 1.1, duration: 0.8)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.8)
        let pulseSequence = SKAction.sequence([scaleUp, scaleDown])
        run(.repeatForever(pulseSequence))
    }
    
    override func setScale(_ scale: CGFloat) {
        super.setScale(scale)
        updateLabelFontSizeAndPosition()
    }
    
    func setLevelSize(_ size: CGSize) {
        self.size = size
        updateLabelFontSizeAndPosition()
    }
    
    func setLabelFontColor(_ color: SKColor) {
        levelLabel.fontColor = color
    }
    
    func setLevel(_ number: Int) {
        levelNumber = number
        levelLabel.text = "\(number)"
    }
    
    func setLevel(_ number: Int, percentage: CGFloat) {
        levelNumber = number
        levelLabel.text = "\(number)"
        fontSizePercentage = percentage
        updateLabelFontSizeAndPosition()
    }
    
    func setTexture(_ texture: String) {
        self.texture = SKTexture(imageNamed: texture)
    }
    
    func setTexture(_ texture: SKTexture) {
        self.texture = texture
    }
    
    func setUnlocked() {
        setTexture(LevelState.unlocked.rawValue)
        unlocked = true
    }
    
    func setLocked() {
        setTexture(LevelState.locked.rawValue)
        unlocked = false
    }
    
    func isUnlocked() -> Bool {
        return unlocked
    }
}
