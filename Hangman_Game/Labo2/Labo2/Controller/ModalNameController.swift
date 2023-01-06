//
//  ModalNameController.swift
//  Labo2
//
// Franck Stefani
// Karim Mokni
// Adel Amaouz

import UIKit

class ModalNameController: UIViewController {
    
    var bestScore = UserDefaults().string(forKey: "bestScore")
    let bestScore2 = UserDefaults().string(forKey: "bestScore2")
    var section = UserDefaults.standard.string(forKey: "section")

    @IBOutlet weak var Message: UILabel!
    
    @IBOutlet weak var Score: UILabel!
    
    @IBOutlet weak var EnterName: UITextField!
    
    @IBOutlet weak var Validate: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Validate.layer.cornerRadius = 20
  
        Message.text = "Felcitations!"
                        + "\n Vous venez de battre le meilleur score de la section " + section!
                        + "\n\nEntrez votre nom pour sauvegarder votre score !"
        
        if(section == "Dictionnaire.") {
            Score.text! += String(bestScore!)
            UserDefaults().set(bestScore, forKey: "scoreDico")
        }
        else {
            Score.text! += String(bestScore2!)
            UserDefaults().set(bestScore2, forKey: "scoreFilm")
        }
        
    }
    
    @IBAction func Validate(_ sender: UIButton) {
        if(section == "Dictionnaire.") {
            let nameDico = EnterName.text ?? ""
            UserDefaults().set(nameDico, forKey: "nameDico")
            }
        else {
            let nameFilm = EnterName.text ?? ""
            UserDefaults().set(nameFilm, forKey: "nameFilm")
        }
    }
    
    @IBAction func DismissKeyboard(_ sender: UITapGestureRecognizer) {
        EnterName.resignFirstResponder()
    }
    
}

extension ModalNameController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          EnterName.resignFirstResponder()
          return true
       }
}
