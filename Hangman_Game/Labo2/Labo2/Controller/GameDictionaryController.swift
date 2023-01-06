//
//  GameDictionaryController.swift
//  Labo2
//
// Franck Stefani
// Karim Mokni
// Adel Amaouz

import UIKit

class GameDictionaryController: UIViewController {

    var stat = StatsController()
    var correctLetters = [String]()
    var wordText = ""
    var score: Int = 60
    var lastButtonPressed: UIButton?
    var mot: String? = nil
    var section: String = "Dictionnaire."
   
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
        
        DictionaryService.shared.getWord { (success, word) in
            self.toggleActivityIndicator(shown: false)
            
            if success, let mot = word {
                self.update(word: mot)
                self.initialiserMot()
            } else {
                self.presentAlert()
            }
        }
    }
    
    @IBAction func letterPressed(_ sender: UIButton) {
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
    
    private func initialiserMot() {
        mot = MotMystere.text!
        print(mot!)
        MotMystere.isHidden = true
        score = 60
        correctLetters = [String]()
        Image.image = UIImage(named: "Hangman-0.png")
        
        Reponse.text = String(repeating: "-", count: mot!.count)
        
        for button in LettersButton {
            button.isEnabled = true
            button.backgroundColor = .systemGray2
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        ActivityIndicator.isHidden = !shown
        New.isHidden = shown
    }

    private func update(word: Dictionary) {
        MotMystere.text = word.word.uppercased()
    }
    
    func correctGuess() {
        var wordText = ""
        
        for letter in mot! {
            let strLetter = String(letter)
                    
            if correctLetters.contains(strLetter) {
                wordText += strLetter
            } else {
                wordText += "-"
            }
        }
        
        Reponse.text = wordText
        
        if wordText == mot {
            win()
        }
    }
    
    func incorrectGuess() {
        score -= 10
        AffichePendu()
            
        if score == 0 {
           alertLost()
        }
    }
    
    func AffichePendu(){
        switch score{
            
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
        if (mot!.count >= 10){
            score += 10
        }
        if (score > UserDefaults().integer(forKey: "scoreDico")) {
            modale()
        } else {
            alertWin()
        }
    }

    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "The quote download failed.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    func alertWin() {
        let ac = UIAlertController(title: "Vous avez gagne! (Mais vous n'avez pas le meilleur score...)" + "\n" + "Reessayez !", message: "Score: " + String(score), preferredStyle: .alert)
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
    
    func modale() {
        UserDefaults().set(section, forKey: "section")
        UserDefaults().set(score, forKey: "bestScore")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "BestPlayer")
        
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .flipHorizontal
        present(vc, animated: true, completion: nil)
    }
    
}
