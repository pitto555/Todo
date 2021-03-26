//
//  ViewController.swift
//  Autoryout
//
//  Created by 光気増井 on 2021/03/04.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    

    @IBOutlet weak var tableView: UITableView!
    
    var todolist = [String]()
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        //保存したデータを読み込む
        if let storedTodoList = userDefaults.array(forKey: "todoList") as? [String] {
            todolist.append(contentsOf: storedTodoList)
        }
    }

   
    @IBAction func pluss(_ sender: Any) {
        
    let data = UIAlertController(title: "Todo", message: "本日の予定", preferredStyle: .alert)

   data.addTextField(configurationHandler: nil)

    let tuikaAction = UIAlertAction(title: "追加", style: .default){(action: UIAlertAction) in
        if let textField = data.textFields?.first{

            self.todolist.insert(textField.text!, at: 0)
            self.tableView.insertRows(at: [IndexPath(row:0,section:0)], with: .automatic)
        }
    }

    let canselAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)

    data.addAction(tuikaAction)
    data.addAction(canselAction)

    present(data, animated: true, completion: nil)
    }
   
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todolist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = todolist[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        todolist.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        
    }
    
}

