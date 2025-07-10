import SpriteKit

class EnergyBar: TSpri {
    private var maxWidth: CGFloat
    private var height: CGFloat
    private var background: TSpri
    private var foreground: TSpri
    private var maxEnergy: Int
    private var currentEnergy: Int
        
    init(maxEnergy: Int, position: CGPoint, zPosition: CGFloat) {
        self.maxEnergy = maxEnergy
        self.currentEnergy = maxEnergy
        self.maxWidth = 40
        self.height = 5
        
        self.background = TSpri(imageNamed: "bar_background", size: CGSize(width: maxWidth, height: height), position: .zero, zPosition: zPosition)
        self.background.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        
        self.foreground = TSpri(imageNamed: "bar_foreground", size: CGSize(width: maxWidth, height: height), position: .zero, zPosition: zPosition)
        self.foreground.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        
        super.init()
        
        self.position = position
        self.zPosition = zPosition
        
        addChild(background)
        addChild(foreground)
        
        updateEnergyBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func getMaxEnergy(_ maxEnergy: Int) {
        self.maxEnergy = maxEnergy
        self.currentEnergy = maxEnergy
        updateEnergyBar()
    }
    
    func updateEnergy(newEnergy: Int) {
        currentEnergy = newEnergy
        updateEnergyBar()
    }
    
    private func updateEnergyBar() {
        let energyRatio = CGFloat(currentEnergy) / CGFloat(maxEnergy)
        let newWidth = maxWidth * energyRatio
//        foreground.size = CGSize(width: max(0, newWidth), height: height)
        foreground.run(.resize(toWidth: max(0, newWidth), duration: 0.1))
    }
    
    func selfDestruct() {
        isHidden = true
        removeAllActions()
        removeFromParent()
    }
    
    override var size: CGSize {
        didSet {
            setSize(width: size.width, height: size.height)
        }
    }
    
    private func setSize(width: CGFloat, height: CGFloat) {
        self.maxWidth = width
        self.height = height
        self.background.size = CGSize(width: maxWidth, height: height)
        self.foreground.size = CGSize(width: maxWidth, height: height)
        updateEnergyBar()
    }
}
