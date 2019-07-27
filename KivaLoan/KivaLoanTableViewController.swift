//
//  KivaLoanTableViewController.swift
//  KivaLoan
//

//
//

import UIKit

class KivaLoanTableViewController: UITableViewController {

    private let kivaLoanURL = "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=a3e2b221-75e0-45c1-8f97-75acbd43d613"
    private var loans = [Loan]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 92.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        getLatestLoans()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        return loans.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! KivaLoanTableViewCell

        // Configure the cell...
        cell.nameLabel.text = loans[indexPath.row].name
        cell.locationLabel.text = loans[indexPath.row].location
        //cell.useLabel.text = loans[indexPath.row].use
        //cell.amountLabel.text = "$\(loans[indexPath.row].amount)"

        return cell
    }
    
    // MARK: - Helper methods
    
    func getLatestLoans() {
        guard let loanUrl = URL(string: kivaLoanURL) else {
            return
        }
        
        let request = URLRequest(url: loanUrl)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if let error = error {
                print(error)
                return
            }
            
            // Parse JSON data
            if let data = data {
                self.loans = self.parseJsonData(data: data)
                
                // Reload table view
                OperationQueue.main.addOperation({
                    self.tableView.reloadData()
                })
            }
        })
        
        task.resume()
    }
    
    func parseJsonData(data: Data) -> [Loan] {
        
        var loans = [Loan]()
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            
            
            let jsonLoans = jsonResult as! [String:[String:AnyObject]]
            
            let dataarrary = jsonLoans["result"]!["results"] as! [AnyObject]
            
            for jsonLoan in dataarrary  {
                var loan = Loan()
                
                loan.name = jsonLoan["A_Name_Ch"] as! String
                //loan.amount = jsonLoan["loan_amount"] as! Int
                //loan.use = jsonLoan["use"] as! String
                loan.location = jsonLoan["A_Location"] as! String
             
                loans.append(loan)
                
           // print(loans)
            
            }
            
        } catch {
            print(error)
        }
        
        return loans
    }
    
    
    
    
    
    
    
    
   //prepare
    
//    func prepare(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "Todetail" {
//            if let indexPath = self.tableView.indexPathForSelectedRow {
//                //取得被選取到的這一隻動物的資料
//                let object = loans[indexPath.row]
//                //設定在第二個畫面控制器中的資料為這一隻動物的資料
//                let controller = segue.destination as! DetailViewController
//                controller.theAnimalDic = object as AnyObject
//                
//                //print(object)
//            }
//        }
//    }
//    
    
    
    
    
    
    
    


}
