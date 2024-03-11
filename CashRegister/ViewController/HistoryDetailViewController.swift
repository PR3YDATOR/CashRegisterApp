
import UIKit

class HistoryDetailViewController: UIViewController {

    @IBOutlet weak var pName: UILabel!
    @IBOutlet weak var pQty: UILabel!
    @IBOutlet weak var pDate: UILabel!
    @IBOutlet weak var pTotalAmount: UILabel!
    
    var history : History?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pName.text = history?.name
        
        let qty = history?.quantity ?? 0
        pQty.text = "\(qty)"
        pDate.text = history?.purchaseDate
        
        let totalPrice = history?.totalCost ?? 0
        pTotalAmount.text = "Total Price : \(totalPrice)"
        
    }
}
