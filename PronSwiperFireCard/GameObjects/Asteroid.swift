import Foundation
import SpriteKit

class Asteroid: TSpri {
    var _active: Bool = false
    private let _damage: Int
    var _markedForRemoval: Bool = false
    
    enum AsteroidType {
        case small
        case medium
        case large
    }
    let _type: AsteroidType

    init(position: CGPoint, zPosition: CGFloat, type: AsteroidType) {
        self._type = type
        let imageName: String
        let customSize: CGSize
        switch type {
        case .small:
            imageName = "asteroid_small"
            customSize = .withPercentScaled(roundByWidth: 13)
            _damage = 2
        case .medium:
            imageName = "asteroid_medium"
            customSize = .withPercentScaled(roundByWidth: 16)
            _damage = 4
        case .large:
            imageName = "asteroid_large"
            customSize = .withPercentScaled(roundByWidth: 22)
            _damage = 6
        }
        
        super.init(imageNamed: imageName, size: customSize, position: position, zPosition: zPosition)
        reset()
        setupMovement()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func activate() {
        _active = true
        isHidden = false
    }
    
    func getDamage() -> Int {
        return _damage
    }
    
    func getScore() -> Int {
        switch _type {
        case .small:
            return 1
        case .medium:
            return 2
        case .large:
            return 3
        }
    }
    
    func reset() {
        isHidden = true
        _active = false
        removeAllActions()
    }
    
    func deactivate() {
        _active = false
        removeAllActions()
    }
    
    func selfDestruct() {
        _active = false
        isHidden = true
        removeAllActions()
        removeFromParent()
    }
    
    private func setupMovement() {
        let maxWidth = MyScreenSize.screenSize.width
        let maxHeight = MyScreenSize.screenSize.height
        let startX = CGFloat.random(in: maxWidth * 0.1 ... maxWidth * 0.9)
        position = CGPoint(x: startX, y: maxHeight * 1.02)
        
        let speed: CGFloat = _type == .small ? 4.0 : (_type == .medium ? 3.5 : 3.0)
        let moveAction = SKAction.moveTo(y: -maxHeight * 0.01, duration: speed)
        
        run(.sequence([
            moveAction,
            .run { [self] in
                self._markedForRemoval = true
            }
        ]))
    }
}
