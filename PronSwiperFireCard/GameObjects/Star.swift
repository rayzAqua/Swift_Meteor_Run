import Foundation
import SpriteKit

class Star: TSpri {
    var _active: Bool = false
    
    init(size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(imageNamed: "star\(Int.random(in: 1...2))", size: size, position: position, zPosition: zPosition)
        reset()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func activate() {
        _active = true
        isHidden = false
        run(.repeatForever(.sequence([
            .scale(to: 1.2, duration: 0.5),
            .scale(to: 1.0, duration: 0.5)
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
}
