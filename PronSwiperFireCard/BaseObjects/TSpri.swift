import SpriteKit

class TSpri: SKSpriteNode {
    
    init() {
        super.init(texture: SKTexture(imageNamed: "img_null"), color: UIColor.clear, size: CGSize.zero)
    }
    
    init(imageNamed: String, size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(texture: SKTexture(imageNamed: "\(imageNamed)"), color: UIColor.white, size: size)
        self.position = position
        self.zPosition = zPosition
        self.colorBlendFactor = 1.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Sprite init(coder:) has not been implemented")
    }
    
}
