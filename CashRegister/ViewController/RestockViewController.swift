
import UIKit

class RestockViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var stockTableView: UITableView!
    @IBOutlet weak var newQuantity: UITextField!
    var productManager : ProductManager?
    var selectedRow : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productManager!.fetchProducts().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "restockCell", for: indexPath) as! UITableViewCell
        cell.textLabel?.text = productManager!.fetchProducts()[indexPath.row].name
        let qty = productManager!.fetchProducts()[indexPath.row].quantity ?? 0;
        cell.detailTextLabel?.text = "\(qty)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
    }
    
    @IBAction func addRestock(_ sender: Any) {
        if let newQty = newQuantity.text {
            


            if (selectedRow == nil || newQty.isEmpty) {
                var alert = UIAlertController(title: "Error!!", message: "Select a product and quantity!", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
            else {
                productManager!.fetchProducts()[selectedRow!].quantity += Int(newQty)!
                stockTableView.reloadData()
                newQuantity.text = ""
            }
        }
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
   
    

 


    
}
