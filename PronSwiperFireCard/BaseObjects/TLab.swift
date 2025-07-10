import SpriteKit

class TLab: SKLabelNode {
    
    init(text: String, fontSize: CGFloat, fontName: String, color: UIColor, position: CGPoint, zPosition: CGFloat) {
        super.init()
        self.text = text
        self.position = position
        self.zPosition = zPosition
        self.fontName = fontName
        self.color = color
        self.colorBlendFactor = 1.0
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad { self.fontSize = fontSize * 2}
        else { self.fontSize = fontSize}
        
        verticalAlignmentMode = .center
        horizontalAlignmentMode = .center
        
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("SimpleLabel init(coder:) has not been implemented")}
    
    func changeTextWithAnimationScaled(withText text: String) {
        self.text = text
        removeAllActions()
        run(SKAction.sequence([
            SKAction.scale(to: 1.2, duration: 0.1),
            SKAction.scale(to: 1, duration: 0.1)]))
    }
    
    func changeTextWithAnimationScaled(withText text: Int) { changeTextWithAnimationScaled(withText: String(text))}
    func changeTextWithAnimationScaled(withText text: Double) { changeTextWithAnimationScaled(withText: String(text))}
    func changeTextWithAnimationScaled(withText text: CGFloat) { changeTextWithAnimationScaled(withText: String(Double(text)))}
    
}
