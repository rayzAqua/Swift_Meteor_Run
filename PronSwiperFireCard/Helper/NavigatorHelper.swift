import SpriteKit
import UIKit

struct ViewControllerName {
    static let home = "HomeViewController"
    static let level = "LevelViewController"
    static let game = "GameViewController"
    static let gameOver = "GameOverViewController"
}

// MARK: - Navigation Helper
struct NavigationHelper {
    static func presentViewController<T: UIViewController>(storyboardId: String, type: T.Type) {
        guard let storyboard = UIStoryboard(name: "Main", bundle: nil) as UIStoryboard?,
              let viewController = storyboard.instantiateViewController(withIdentifier: storyboardId) as? T else {
            print("Failed to instantiate \(storyboardId)")
            return
        }
        pushViewController(viewController)
    }
    
    static func pushViewController(_ viewController: UIViewController) {
        guard let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else {
            print("Root view controller is not a navigation controller.")
            return
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    static func dismissAllViewControllers() {
        guard var topViewController = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        
        while let presentedViewController = topViewController.presentedViewController {
            topViewController = presentedViewController
        }
        
        topViewController.dismiss(animated: false) {
            if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                navigationController.popToRootViewController(animated: false)
            }
        }
    }
}

extension NavigationHelper {
    static func presentHome() {
        guard let storyboard = UIStoryboard(name: "Main", bundle: nil) as UIStoryboard?,
              let homeVC = storyboard.instantiateViewController(withIdentifier: ViewControllerName.home) as? HomeViewController,
              let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else {
            print("Failed to set HomeViewController as root.")
            return
        }
        navigationController.setViewControllers([homeVC], animated: false)
    }
    static func presentLevel() {
        presentViewController(storyboardId: ViewControllerName.level, type: LevelViewController.self)
    }
    static func presentGame() {
        presentViewController(storyboardId: ViewControllerName.game, type: GameViewController.self)
    }
    static func presentGameOver() {
        presentViewController(storyboardId: ViewControllerName.gameOver, type: GameOverViewController.self)
    }
}
