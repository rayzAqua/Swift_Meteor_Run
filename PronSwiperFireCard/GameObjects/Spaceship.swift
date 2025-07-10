import SpriteKit

class Spaceship: TSpri {
    var _active: Bool = false
    
    init(position: CGPoint, zPosition: CGFloat) {
        super.init(imageNamed: "spaceship", size: .withPercentScaled(roundByWidth: 10), position: position, zPosition: zPosition)
        reset()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func activate() {
        _active = true
        isHidden = false
        run(.repeatForever(.sequence([
            .rotate(byAngle: 0.1, duration: 0.2),
            .rotate(byAngle: -0.1, duration: 0.2)
        ])))
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
    
    func move(to position: CGPoint) {
        let safeX = max(MyScreenSize.screenSize.width * 0.1, min(position.x, MyScreenSize.screenSize.width * 0.9))
        let safeY = max(MyScreenSize.screenSize.height * 0.1, min(position.y, MyScreenSize.screenSize.height * 0.9))
        run(.move(to: CGPoint(x: safeX, y: safeY), duration: 0.1))
    }
}
