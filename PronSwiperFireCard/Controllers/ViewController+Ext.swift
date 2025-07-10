import UIKit

extension UIViewController {
    func addBackgroundImage() {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        imgView.image = UIImage(named: "img_background")
        imgView.contentMode = .scaleToFill
        self.view.addSubview(imgView)
        self.view.sendSubviewToBack(imgView)
    }
}

