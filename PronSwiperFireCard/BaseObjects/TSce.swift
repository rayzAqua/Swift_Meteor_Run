import SpriteKit

class TSce: SKScene {
    var buttons = [TBtn]()
    
    let genericBackground = TSpri.init(imageNamed: "img_background", size: CGSize.withPercent(100, height: 100), position: MyScreenSize.center(), zPosition:ConstantConfiguration.zPosition.layer_1)
                
    let scoreLbl = TLab(text: "Score: 0/0", fontSize: 25, fontName: UIFont.familyNames[20], color: UIColor.black, position: CGPoint.withPercent(50, y: 94), zPosition:ConstantConfiguration.zPosition.layer_5)
        
    func addChild(_ button: TBtn) {
        buttons.append(button)
        super.addChild(button)
    }
    
    func addChild(_ nodes: [SKNode]) {
        for (_, value) in nodes.enumerated() {
            if value.isKind(of: TBtn.self) {
                addChild(value as! TBtn)
            } else {
                addChild(value)
            }
        }
    }
    
    func changeSceneTo(scene : SKScene) {
        view?.presentScene(scene)
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(cleanOldScene), userInfo: nil, repeats: false)
    }
    
    func changeSceneTo(scene : SKScene, withTransition transition: SKTransition) {
        view?.presentScene(scene, transition: transition)
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(cleanOldScene), userInfo: nil, repeats: false)
    }
    
    @objc func cleanOldScene() {
        removeAllChildren()
        removeAllActions()
        removeFromParent()
        print("GlobalScene: Old scene is been cleaned")
    }
    
}
