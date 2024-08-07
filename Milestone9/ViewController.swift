//
//  ViewController.swift
//  Milestone9
//
//  Created by Davuthan Kurt on 30.07.2024.
//

import UIKit

class ViewController: UIViewController {

    var cardsView: UIView!
    var card: Button!
    var cards = ["cardCircle", "cardCross", "cardLines", "cardSquare", "cardStar", "cardCircle", "cardCross", "cardLines", "cardSquare", "cardStar"]
    var cards2 = ["cardCircle", "cardCross", "cardLines", "cardSquare", "cardStar", "cardCircle", "cardCross", "cardLines", "cardSquare", "cardStar"]
    var activeCard = 0
    var cardsArray = [Button] ()
    var activeCard1: Button!
    var activeCard2: Button!
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        cardsView = UIView()
        cardsView.translatesAutoresizingMaskIntoConstraints = false
//        cardsView.backgroundColor = UIColor.orange
        view.addSubview(cardsView)
        
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 10
        verticalStackView.distribution = .fillEqually
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        cardsView.addSubview(verticalStackView)
        
        
        NSLayoutConstraint.activate([
            cardsView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            cardsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            cardsView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            cardsView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            verticalStackView.topAnchor.constraint(equalTo: cardsView.topAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: cardsView.bottomAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: cardsView.leadingAnchor, constant: 70),
            verticalStackView.trailingAnchor.constraint(equalTo: cardsView.trailingAnchor, constant: -70)
        ])
        
        cards.shuffle()
        var count = 0
        var counter = 0
        for _ in 0..<2 {
            let horizontalStackView = UIStackView()
            horizontalStackView.axis = .horizontal
            horizontalStackView.spacing = 10
            horizontalStackView.distribution = .equalSpacing
            horizontalStackView.alignment = .center
            
            for _ in 0..<5 {
                card = Button(type: .custom)
                
                card.cardImage = UIImage(named: cards[count])
                card.cardName = cards[count]
                
                cards2.remove(at: cards2.firstIndex(of: cards[count])!)
                
                if cards2.contains(card.cardName) {
                    card.tag = counter
                    counter += 1
                } else {
                    for i in 0..<cardsArray.count {
                        if cardsArray[i].cardName == card.cardName {
                            card.tag = cardsArray[i].tag
                        }
                    }
                }
                
                count += 1
                cardsArray.append(card)
                
                
                card.translatesAutoresizingMaskIntoConstraints = false
                
                card.addTarget(self, action: #selector(cardTapped), for: .touchUpInside)
                
                
                card.setImage(UIImage(named: "cardBack"), for: .normal)
                card.imageView?.translatesAutoresizingMaskIntoConstraints = false
                card.imageView?.contentMode = .scaleAspectFit
                
                
                NSLayoutConstraint.activate([
                    card.widthAnchor.constraint(equalToConstant: 150),
                    card.heightAnchor.constraint(equalToConstant: 220),
                 ])
                
                if let imageView = card.imageView {
                    NSLayoutConstraint.activate([
                        imageView.widthAnchor.constraint(equalTo: card.widthAnchor),
                        imageView.heightAnchor.constraint(equalTo: card.heightAnchor),
                        imageView.centerXAnchor.constraint(equalTo: card.centerXAnchor),
                        imageView.centerYAnchor.constraint(equalTo: card.centerYAnchor)
                    ])
                }
                horizontalStackView.addArrangedSubview(card)
            }

            
            verticalStackView.addArrangedSubview(horizontalStackView)

        }


    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
//        print(cardsView.bounds.size)
    }
    
    @objc func cardTapped(_ sender: Button){
        activeCard += 1
        
        
        if activeCard == 1 {
            activeCard1 = sender
            activeCard1.setImage(activeCard1.cardImage, for: .normal)
            
        } else if activeCard == 2{
            activeCard2 = sender
            activeCard2.setImage(activeCard2.cardImage, for: .normal)
            
            if activeCard1.tag == activeCard2.tag {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.activeCard1.isEnabled = false
                    self.activeCard2.isEnabled = false
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.activeCard1.setImage(UIImage(named: "cardBack"), for: .normal)
                    self.activeCard2.setImage(UIImage(named: "cardBack"), for: .normal)
                }
                
            }
            activeCard = 0
        }
    }

}

