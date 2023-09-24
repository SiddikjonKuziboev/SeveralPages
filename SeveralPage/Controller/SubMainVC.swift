//
//  SubMainVC.swift
//  SeveralPage
//
//  Created by Kuziboev Siddikjon on 24/09/23.
//

import UIKit

class SubMainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var answer: Answer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        setTitleToNavigation(title: answer.question_text ?? "")
    }
    
    private func setTitleToNavigation(title: String) {
        navigationItem.title = title
    }

    @IBAction func doneBtnTapped(_ sender: Any) {
    }
}

extension SubMainVC: UITableViewDelegate, UITableViewDataSource {
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AddressDetailedTVC.self, forCellReuseIdentifier: "AddressDetailedTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answer.sub_answers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressDetailedTVC", for: indexPath)as! AddressDetailedTVC
        let question = answer.sub_answers?[indexPath.row]
        cell.configureForSub(answers: question)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _ = answer.sub_answers?[indexPath.row].sub_answers {
           print("Hello!!!")
            let data = answer.sub_answers?[indexPath.row]
            let vc = SubMainVC()
//            vc.answer = data.
            navigationController?.pushViewController(vc, animated: true)

        }else {
            handleUserSelectedRow(indexPath)
        }
        
    }
    
    private func handleUserSelectedRow(_ indexPath: IndexPath) {
        
        guard var answers = answer.sub_answers else{return}
        for i in answers.enumerated() {
            answers[i.offset].isSelected = false
        }
        answers[indexPath.row].isSelected.toggle()
        answer.sub_answers = answers
        tableView.reloadData()
    }
    
}
