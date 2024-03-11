
import Foundation

class History {
    var name: String
    var quantity: Int
    var totalCost: Double
    var purchaseDate : String
    
    init(histName:String, histQty:Int, histCost:Double) {
        name = histName
        quantity = histQty
        totalCost = histCost
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss a"
        purchaseDate = dateFormatter.string(from: NSDate() as Date)
    }
}
