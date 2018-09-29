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
        historyData.insert(textField.text ?? "", at: 0)
        UserDefaults.standard.set(historyData, forKey: "key")
        textField.text = ""
        tableView.reloadData()
    }
    
    var historyData:[String]=[]
    var ResultData:[String]=[]
    var word: String = ""
    var relatedQuery: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "HistoryCell", bundle: nil), forCellReuseIdentifier: HistoryCell.reusableIdentifier)
        tableView.register(UINib(nibName: "SearchResultCell", bundle: nil), forCellReuseIdentifier: SearchResultCell.reusableIdentifier)
        guard let data = UserDefaults.standard.array(forKey: "key") as? [String] else { return print("Loding fail")}
        ResultData = data
    }
    
    
    func takeData(){
        let todosEndpoint = "https://en.wikipedia.org/w/api.php?action=opensearch&search=\(textField.text!)&limit=20&namespace=0&format=json"
        guard let todoURL = URL(string: todosEndpoint) else {return print("fail")}
        let todosUrlRequest = URLRequest(url: todoURL)
        let task = URLSession.shared.dataTask(with: todosUrlRequest) { (data, response, error) in
            guard error == nil else { return print(error!) }
            guard let data = data else { return print("data가 없습니다.") }
            do {
                let receivedTodo = try JSONDecoder().decode([Search].self, from: data)
                guard let word = receivedTodo[0].word  else {return print("fail1")}
                guard let relatedQuery = receivedTodo[1].relatedQuery else {return print("fail1")}
                self.word = word
                self.relatedQuery = relatedQuery
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch  {
                print("parsing response가 잘못되었습니다.")
                return
            }
        }
        task.resume()
}

}


extension ViewController : UITextFieldDelegate {

    @available(iOS 2.0, *)
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        takeData()
        return true
    }

}

extension ViewController : UITableViewDelegate {
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//        textField.text = historyData[indexPath.row]
    }

}

extension ViewController : UITableViewDataSource{
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if textField != nil{
            return relatedQuery.count
        }else{
            return historyData.count
        }

    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        switch textField != nil {
        case true:
            tableView.rowHeight = 50
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.reusableIdentifier, for: indexPath) as! SearchResultCell
            print(relatedQuery)

            cell.searchResultLabel.text = relatedQuery[indexPath.row]
//            tableView.reloadData()
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
