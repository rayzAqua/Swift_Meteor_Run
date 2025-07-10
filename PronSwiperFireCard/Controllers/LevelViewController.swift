import UIKit
import SpriteKit
import GameplayKit

class LevelViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let skView = SKView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        let scene = LevelScene(size: skView.bounds.size)
        skView.presentScene(scene)
        view.addSubview(skView)
    }
}
