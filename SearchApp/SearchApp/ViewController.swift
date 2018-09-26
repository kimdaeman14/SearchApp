//
//  ViewController.swift
//  SearchApp
//
//  Created by kimdaeman14 on 2018. 9. 27..
//  Copyright © 2018년 A3LCamel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBAction func searchButton(_ sender: UIButton) {
//        print("searchButton")
        historyData.insert(textField.text ?? "", at: 0)
        textField.text = ""
        tableView.reloadData()
    }
    
    var historyData:[String]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "HistoryCell", bundle: nil), forCellReuseIdentifier: HistoryCell.reusableIdentifier)
        tableView.register(UINib(nibName: "SearchResultCell", bundle: nil), forCellReuseIdentifier: SearchResultCell.reusableIdentifier)
    }
}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        print("textFieldShouldReturn")
        historyData.insert(textField.text ?? "", at: 0)
        textField.text = ""
        tableView.reloadData()
        return true
    }
    
    
    @available(iOS 2.0, *)
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("shouldChangeCharactersIn")
        print(range)
        return true
    }

}

extension ViewController : UITableViewDelegate {
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        textField.text = historyData[indexPath.row]
    }
    
    

}

extension ViewController : UITableViewDataSource{
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
//        print("numberOfRowsInSection")
        return historyData.count
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        switch textField == nil {
        case true:
            tableView.rowHeight = 50
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.reusableIdentifier, for: indexPath)
            return cell
        case false:
            tableView.rowHeight = 50
            let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.reusableIdentifier, for: indexPath) as! HistoryCell
            cell.historyLabel.text = historyData[indexPath.row]
            return cell
        }
        
    }
    
    @available(iOS 2.0, *)
    public func numberOfSections(in tableView: UITableView) -> Int {
//        print("numberOfSections")
    return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let header:String? = "Search History"
        if textField != nil {
            return header
        }else{
            return nil
        }
    }
    
}
