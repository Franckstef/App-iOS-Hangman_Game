//
//  StatsController.swift
//  Labo2
//
// Franck Stefani
// Karim Mokni
// Adel Amaouz

import UIKit

class StatsController: UIViewController {
  
    @IBOutlet weak var topScoreDico: UILabel!
    
    @IBOutlet weak var topScoreFilm: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let nameDico = UserDefaults().string(forKey: "nameDico")
        let scoreDico = UserDefaults().integer(forKey: "scoreDico")
        let nameFilm = UserDefaults().string(forKey: "nameFilm")
        let scoreFilm = UserDefaults().integer(forKey: "scoreFilm")
        
        topScoreDico.text = (nameDico ?? "Player 1") + "\n\n" + String(scoreDico)
        topScoreFilm.text = (nameFilm ?? "Player 2") + "\n\n" + String(scoreFilm)
    }

}
