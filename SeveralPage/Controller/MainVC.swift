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
    var allQuestionsCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       questions = CustomQuestion.questions()
        allQuestionsCount = questions.count
        setUpTableView()
        setTitleToNavigation(title: "Hello")
    }
    
    private func setTitleToNavigation(title: String) {
        navigationItem.title = title
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        if allQuestionsCount-1 > questionIndex {
            questionIndex += 1
            setTitleToNavigation(title: questions[questionIndex].question)
            
            
            // Update data source with the next set of questions

             UIView.transition(with: tableView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                 self.tableView.reloadData()
             }, completion: nil)

             // Optionally, you can also animate cell appearance
             animateCellAppearance()
        }
    }
    
    //Table View
    func animateCellAppearance() {
        let cells = tableView.visibleCells
        var delay: TimeInterval = 0.0
        
        for cell in cells {
            cell.alpha = 0.0
            UIView.animate(withDuration: 0.5, delay: delay, options: .curveEaseInOut, animations: {
                cell.alpha = 1.0
            }, completion: nil)
            delay += 0.1  // Adjust the delay between cell animations as needed
        }
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AddressDetailedTVC.self, forCellReuseIdentifier: "AddressDetailedTVC")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.isEmpty ? 0 : questions[questionIndex].answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressDetailedTVC", for: indexPath)as! AddressDetailedTVC
        let question = questions[questionIndex].answers[indexPath.row]
        cell.configure(answers: question)
        
//        cell.alpha = 0.0  // Make the cell initially invisible
//
//        UIView.animate(withDuration: 0.3) {
//            cell.alpha = 1.0  // Fade in the cell
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _ = questions[questionIndex].answers[indexPath.row].question_text {
            let vc = SubMainVC()
            vc.answer = questions[questionIndex].answers[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }else {
            handleUserSelectedRow(indexPath)
        }
        
    }
    
    private func handleUserSelectedRow(_ indexPath: IndexPath) {
        var answers = questions[questionIndex].answers
        for i in answers.enumerated() {
            answers[i.offset].isSelected = false
        }
        answers[indexPath.row].isSelected.toggle()
        questions[questionIndex].answers = answers
        tableView.reloadData()
    }
    
}
