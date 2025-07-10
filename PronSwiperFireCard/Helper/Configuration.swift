import Foundation
import SpriteKit

struct ConstantConfiguration {
    static let bestLevel = "bestLevel"
    static let level = "level"
    static let isWin = "isWin"
    static let titleLabelFont = UIFont.familyNames[2]
    static let levelLabelFont = UIFont.familyNames[2]
        
    struct zPosition {
        static let layer_1: CGFloat = 0
        static let layer_2: CGFloat = 1
        static let layer_3: CGFloat = 2
        static let layer_4: CGFloat = 3
        static let layer_5: CGFloat = 4
    }
    
    enum GameState {
        case None
        case Init
        case Play
        case Win
        case End
        case Wait
    }
}
