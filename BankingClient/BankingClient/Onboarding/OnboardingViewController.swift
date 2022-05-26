//
//  OnboardingViewController.swift
//  BankingClient
//
//  Created by Omar Khayyam on 2022-05-26.
//

import Lottie
import UIKit

class OnboardingViewController: UIViewController {

    let stackView = UIStackView()
    let animationView = AnimationView()
    let label = UILabel()

    var animationName: String
    var labelText: String

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }

    init(animationName: String, labelText: String) {
        self.animationName = animationName
        self.labelText = labelText
        super.init(nibName: nil, bundle: nil)
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnboardingViewController {
    func style() {
        view.backgroundColor = .systemBackground
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20

        // Animation
        animationView.translatesAutoresizingMaskIntoConstraints =  false
        animationView.animation = Animation.named(animationName)
        animationView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        animationView.backgroundColor = .white
        animationView.contentMode = .scaleAspectFit
        DispatchQueue.main.async {
            self.animationView.currentProgress = 0
            self.animationView.play()
            self.animationView.loopMode = .loop
            self.animationView.backgroundBehavior = .pauseAndRestore
        }


        // Label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.text = labelText

    }

    func layout() {
        stackView.addArrangedSubview(animationView)
        stackView.addArrangedSubview(label)

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            label.centerYAnchor.constraint(equalTo: stackView.centerYAnchor, constant: 250)
        ])

    }
}
