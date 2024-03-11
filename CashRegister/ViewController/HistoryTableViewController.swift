
import UIKit

class HistoryTableViewController: UITableViewController {
    
    var historyManager : HistoryManager?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (historyManager?.fetchPurchaseHistory().count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = historyManager!.fetchPurchaseHistory()[indexPath.row].name
        
        let qty = historyManager!.fetchPurchaseHistory()[indexPath.row].quantity ?? 0;
        cell.detailTextLabel?.text = "\(qty)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedHistory = historyManager?.fetchPurchaseHistory()[indexPath.row]

        if let viewController = storyboard?.instantiateViewController(identifier:"HistoryDetailViewController") as? HistoryDetailViewController {
                viewController.history = selectedHistory
                navigationController?.pushViewController(viewController, animated: true)
            }
    }
    
}
