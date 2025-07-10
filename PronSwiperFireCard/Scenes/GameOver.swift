import Foundation
import SpriteKit


private struct LayoutConstants {
    static let buttonWidthRatio: CGFloat = 0.4
    static let buttonHeightRatio: CGFloat = 0.18
    static let titlePosXPercent: CGFloat = 50
    static let titlePosYPercent: CGFloat = 75
    
    struct WinPositions {
        static let titleFontSize: CGFloat = 37
        static let nextPosXPercent: CGFloat = 50
        static let nextPosYPercent: CGFloat = 60
        static let restartPosXPercent: CGFloat = 50
        static let restartPosYPercent: CGFloat = 50
        static let homePosXPercent: CGFloat = 50
        static let homePosYPercent: CGFloat = 40
    }
    
    struct LosePositions {
        static let titleFontSize: CGFloat = 50
        static let restartPosXPercent: CGFloat = 50
        static let restartPosYPercent: CGFloat = 55
        static let homePosXPercent: CGFloat = 50
        static let homePosYPercent: CGFloat = 45
    }
}

private enum ButtonName: String {
    case restart = "btn_restart"
    case home = "btn_home"
    case next = "btn_next"
}

class GameOver: TSce {
    private let titleLabel = SKLabelNode()
    private let restartButton = TBtn(normalTextureName: ButtonName.restart.rawValue, size: .zero, position: .zero, zPosition: 5.0)
    private let homeButton = TBtn(normalTextureName: ButtonName.home.rawValue, size: .zero, position: .zero, zPosition: 5.0)
    private let nextButton = TBtn(normalTextureName: ButtonName.next.rawValue, size: .zero, position: .zero, zPosition: 5.0)
    private let screenSize = UIScreen.main.bounds.size
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupBackground()
        setupTitle()
        setupButtons()
        configureLayoutForGameResult()
    }
    
    private func setupBackground() {
        addChild(genericBackground)
    }
    
    private func setupTitle() {
        titleLabel.fontName = ConstantConfiguration.titleLabelFont
        titleLabel.fontColor = .white
        titleLabel.zPosition = 5
        titleLabel.position = .withPercent(LayoutConstants.titlePosXPercent, y: LayoutConstants.titlePosYPercent)
        addChild(titleLabel)
    }
    
    private func setupButtons() {
        let buttonSize = CGSize(
            width: screenSize.width * LayoutConstants.buttonWidthRatio,
            height: screenSize.width * LayoutConstants.buttonHeightRatio
        )
        
        [nextButton, restartButton, homeButton].forEach { button in
            button.size = buttonSize
        }
    }
    
    private func configureLayoutForGameResult() {
        let isWin = UserDefaults.standard.bool(forKey: ConstantConfiguration.isWin)
        titleLabel.text = isWin ? "CONGRAULATIONS!" : "GAME OVER"
        
        if isWin {
            titleLabel.fontSize = LayoutConstants.WinPositions.titleFontSize

            addChild(nextButton)
            nextButton.position = .withPercent(LayoutConstants.WinPositions.nextPosXPercent, y: LayoutConstants.WinPositions.nextPosYPercent)
            addChild(restartButton)
            restartButton.position = .withPercent(LayoutConstants.WinPositions.restartPosXPercent, y: LayoutConstants.WinPositions.restartPosYPercent)
            addChild(homeButton)
            homeButton.position = .withPercent(LayoutConstants.WinPositions.homePosXPercent, y: LayoutConstants.WinPositions.homePosYPercent)
        } else {
            titleLabel.fontSize = LayoutConstants.LosePositions.titleFontSize

            addChild(restartButton)
            restartButton.position = .withPercent(LayoutConstants.LosePositions.restartPosXPercent, y: LayoutConstants.LosePositions.restartPosYPercent)
            addChild(homeButton)
            homeButton.position = .withPercent(LayoutConstants.LosePositions.homePosXPercent, y: LayoutConstants.LosePositions.homePosYPercent)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else {
            return
        }
        
        switch true {
        case nextButton.contains(location):
            nextButton.touchUp()
            handleNextLevel()
        case restartButton.contains(location):
            restartButton.touchUp()
            transition(to: .level)
        case homeButton.contains(location):
            homeButton.touchUp()
            transition(to: .home)
        default:
            break
        }
        
    }
    
    private enum SceneInfo{
        case home
        case level
        case game
    }
    
    private func transition(to scene: SceneInfo) {
        NavigationHelper.dismissAllViewControllers()
        switch scene {
        case .home:
            NavigationHelper.presentHome()
        case .level:
            NavigationHelper.presentLevel()
        case .game:
            NavigationHelper.presentGame()
        }
        view?.presentScene(nil)
    }
    
    private func handleNextLevel() {
        let level = UserDefaults.standard.integer(forKey: "level")
        UserDefaults.standard.set(level + 1, forKey: "level")
        transition(to: .game)
    }
    
}

