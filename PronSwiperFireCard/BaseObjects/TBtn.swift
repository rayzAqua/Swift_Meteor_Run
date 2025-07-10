import SpriteKit

class TBtn: TSpri {
    private var currentState: State = .normal {
        didSet {
            updateAppearance()
        }
    }
    
    private enum State: Int8 {
        case normal = 1
        case pressed = 2
    }
    
    override init() {
        super.init(imageNamed: "img_null", size: .zero, position: .zero, zPosition: 0)
    }
    
    init(normalTextureName: String, size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(imageNamed: normalTextureName, size: size, position: position, zPosition: zPosition)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateAppearance() {
        removeAllActions()
        let scale: CGFloat = currentState == .normal ? 1.0 : 0.85
        let action = SKAction.scale(to: scale, duration: 0.025)
        run(action)
    }
    
    func touchDown() {
        currentState = .pressed
    }
    
    func touchDown(at location: CGPoint) {
        guard contains(location) else { return }
        touchDown()
    }
    
    func touchUp() {
        currentState = .normal
    }
    
    func setTexture(_ textureName: String) {
        texture = SKTexture(imageNamed: textureName)
    }
}
