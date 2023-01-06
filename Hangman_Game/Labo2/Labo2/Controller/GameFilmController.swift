//
//  GameFilmController.swift
//  Labo2
//
// Franck Stefani
// Karim Mokni
// Adel Amaouz
//

import UIKit

class GameFilmController: UIViewController {
    
    let caracSpecial: String = "0123456789 ,.-'\"_;:#"
    var correctLetters = [String]()
    var wordText = ""
    var score2: Int = 60
    var lastButtonPressed: UIButton?
    var mot: String? = nil
    var section: String = "Film."

    @IBOutlet weak var Image: UIImageView!
    
    @IBOutlet weak var MotMystere: UILabel!
    
    @IBOutlet var LettersButton: [UIButton]!
    
    @IBOutlet weak var Reponse: UILabel!
    
    @IBOutlet weak var New: UIButton!
    
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        New.layer.cornerRadius = 20
        LettersButton.forEach { $0.layer.cornerRadius = 12 }
        
        MotMystere.text = ""
        Reponse.text = ""
        self.Jouer(UIButton.self)
        toggleActivityIndicator(shown: false)
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true)
    }
 
    @IBAction func Jouer(_ sender: Any) {
        toggleActivityIndicator(shown: true)
        
        MovieService.shared.getMovie { (success, title, released, genre, acteur, realisateur, rating) in
            self.toggleActivityIndicator(shown: false)
            
            if success {
                self.update(title: title)
                self.initialiserMot()
            } else {
                self.presentAlert()
            }
        }
    }
    
    @IBAction func LetterPressed(_ sender: UIButton) {
        mot = MotMystere.text!
        if sender != lastButtonPressed {
                   lastButtonPressed = sender
               }
        
        let usedLetters = sender.currentTitle
        
        if mot!.contains(usedLetters!) {
            correctLetters.append(usedLetters!)
            correctGuess()
        }else {
            incorrectGuess()
        }
        
        lastButtonPressed?.backgroundColor = .darkGray
        lastButtonPressed?.isEnabled = false
    }
    
    func initialiserMot() {
        mot = MotMystere.text!
        print(mot!)
        MotMystere.isHidden = true
        score2 = 60
        
        correctLetters = [String]()
        Image.image = UIImage(named: "Hangman-0.png")
        var reponse = ""
        
        for letter in mot! {
            let strLetter = String(letter)
                    
            if caracSpecial.contains(strLetter) {
                reponse += strLetter
            } else {
                reponse += "-"
            }
        }
    
        Reponse.text = reponse
        
        for button in LettersButton {
            button.isEnabled = true
            button.backgroundColor = .systemGray2
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        ActivityIndicator.isHidden = !shown
        New.isHidden = shown
    }

    private func update(title: String) {
        MotMystere.text = title.uppercased()
    }
    
    func correctGuess() {
        wordText = ""
        
        for letter in mot! {
            let strLetter = String(letter)
                    
            if correctLetters.contains(strLetter) {
                wordText += strLetter
            }else if caracSpecial.contains(strLetter) {
                wordText += strLetter
            }else {
                wordText += "-"
            }
        }
        
        Reponse.text = wordText
        
        if wordText == mot {
            win()
        }
    }
    
    func incorrectGuess() {
        score2 -= 10
        AffichePendu()
            
        if score2 == 0 {
           alertLost()
        }
        if score2 == 40 {
            MovieService.shared.getMovie { (true ,title, released, genre, acteur, realisateur, rating) in
                if true {
                    self.indice1Alert(filmReleased: released)
                }
            }
            
        }else
        
        if score2 == 20 {
            
            MovieService.shared.getMovie { (true ,title, released, genre, acteur, realisateur, rating) in
                if true {
                   self.indice2Alert( filmGenre : genre, filmRating: rating)
                }
            }
            
        }else
        
        if score2 == 10 {
            
            MovieService.shared.getMovie { (true ,title, released, genre, acteur, realisateur, rating) in
                if true {
                   self.indice3Alert(filmActeur : acteur ,filmRealisateur : realisateur )
                }
            }
            
        }
    }
    
    func AffichePendu(){
        switch score2{
            
        case 50:
            Image.image = UIImage(named: "Hangman-1.png")
        case 40:
            Image.image = UIImage(named: "Hangman-2.png")
        case 30:
            Image.image = UIImage(named: "Hangman-3.png")
        case 20:
            Image.image = UIImage(named: "Hangman-4.png")
        case 10:
            Image.image = UIImage(named: "Hangman-5.png")
        case 0:
            Image.image = UIImage(named: "Hangman-6.png")
        default:
            Image.image = UIImage(named: "Hangman-0.png")
        }
    }
    
    func win() {
        if (mot!.count >= 15){
            score2 += 10
        }
        if (score2 > UserDefaults().integer(forKey: "scoreFilm")) {
            modale()
        } else {
            alertWin()
        }
    }

    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "The movie title download failed.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    func alertWin() {
        let ac = UIAlertController(title: "Vous avez gagne! (Mais vous n'avez pas le meilleur score...)" + "\n" + "Reessayez !", message: "Score: " + String(score2), preferredStyle: .alert)
        let rejouer = UIAlertAction(title: "Rejouer", style: .default) { _ in self.Jouer(UIButton.self)}
        ac.addAction(rejouer)
        let quitter = UIAlertAction(title: "Quitter", style: .destructive) { _ in self.dismiss(UIButton.self)}
        ac.addAction(quitter)
        present(ac, animated: true)
    }
    
    func alertLost() {
        let ac = UIAlertController(title: "Vous avez perdu !" + "\n" + "Le mot mystere etait:\n", message: mot!, preferredStyle: .alert)
        let rejouer = UIAlertAction(title: "Rejouer", style: .default) { _ in self.Jouer(UIButton.self)}
        ac.addAction(rejouer)
        let quitter = UIAlertAction(title: "Quitter", style: .destructive) { _ in self.dismiss(UIButton.self)}
        ac.addAction(quitter)
        present(ac, animated: true)
    }
    
    private func indice1Alert(filmReleased: String) {
        let alertVC = UIAlertController(title: "Indice1", message: "L'annee de sortie est: \(filmReleased)", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    private func indice2Alert(filmGenre: String, filmRating: String) {
        let alertVC = UIAlertController(title: "Indice2", message: "Le genre est: \(filmGenre) et son evaluation est : \(filmRating) ", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    private func indice3Alert(filmActeur: String, filmRealisateur: String) {
        let alertVC = UIAlertController(title: "Indice3", message: "L(es) acteur(s) est(sont): \(filmActeur), et Le(s) realisateur(s) est(sont) : \(filmRealisateur)", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    func modale() {
        UserDefaults().set(section, forKey: "section")
        UserDefaults().set(score2, forKey: "bestScore2")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "BestPlayer")
        
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .flipHorizontal
        present(vc, animated: true, completion: nil)
    }
    
}
