//
//  BaremeController.swift
//  Labo2
//
// Franck Stefani
// Karim Mokni
// Adel Amaouz

import UIKit

class BaremeController: UIViewController {

    
    @IBOutlet weak var Bareme: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Bareme.text = "Bareme\n\n"
                        + "Le bareme des scores est le suivant: \n\n"
                        + "0 erreur = 60 points\n"
                        + "1 erreurs = 50 points\n"
                        + "2 erreurs = 40 points\n"
                        + "3 erreurs = 30 points\n"
                        + "4 erreurs = 20 points\n"
                        + "5 erreurs = 10 points\n"
                        + "6 erreurs = C'est perdu\n\n"
                        + "Bonus de 10 points si le mot contient plus de 10 lettre ou si le titre du film contient plus que 15 lettres !"
    }
    
}
