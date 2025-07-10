import UIKit
import StoreKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundImage()
    }
    
    @IBAction func btnShare(_ sender: Any) {
        let objectsToShare = ["Best app ever"]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        activityVC.popoverPresentationController?.sourceRect = CGRect(x: 100, y: 200, width: 300, height: 300)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @available(iOS 10.3, *)
    @IBAction func btnRate(_ sender: Any) {
        SKStoreReviewController.requestReview()
    }
}
