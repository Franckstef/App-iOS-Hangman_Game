//
//  FilmController.swift
//  Labo2
//
// Franck Stefani
// Karim Mokni
// Adel Amaouz

import UIKit

class WelcomeFilmController: UIViewController {

    @IBOutlet weak var Regles: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Regles.text = "Bienvenue !\n\n"
                    + "Le pendu est un jeu consistant à trouver un mot en devinant quelles sont les lettres qui le composent.\n\n"
                    + "Vous avez 6 chances pour deviner le titre du film !\n\n"
                    + "Vous aurez le droit a des indices pendant la partie :)"
    }
    


}
