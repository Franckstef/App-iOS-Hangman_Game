//
//  DictionaryController.swift
//  Labo2
//
// Franck Stefani
// Karim Mokni
// Adel Amaouz

import UIKit

class WelcomeDictionaryController: UIViewController {

    @IBOutlet weak var Regles: UILabel!
    
    @IBAction func unwindToWelcome(segue:UIStoryboardSegue) { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        Regles.text = "Bienvenue !\n\n"
                    + "Le pendu est un jeu consistant à trouver un mot en devinant quelles sont les lettres qui le composent.\n\n"
                    + "Vous avez 6 chances pour deviner le mot mystere (en anglais) !"
    }
    
}
