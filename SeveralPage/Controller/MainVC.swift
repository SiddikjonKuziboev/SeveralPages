//
//  MainVC.swift
//  SeveralPage
//
//  Created by Kuziboev Siddikjon on 23/09/23.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var questions: [CustomQuestion] = []
    var questionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       questions = CustomQuestion.questions()
        setUpTableView()
    }
    
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.isEmpty ? 0 : questions[questionIndex].answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "12345")
        let text = questions[questionIndex].answers[indexPath.row]
        cell.textLabel?.text = text.answer_text
        return cell
    }
    
    
}
