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
    let nextButton = UIButton(type: .system)

    var animationName: String
    var labelText: String
    var isLastPage: Bool
    weak var delegate: OnboardingContainerViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }

    init(animationName: String, labelText: String, isLastPage: Bool = false) {
        self.animationName = animationName
        self.labelText = labelText
        self.isLastPage =  isLastPage
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

        // Next Button
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.configuration = .filled()
        nextButton.setTitle(self.isLastPage ? "Done" : "Next", for: [])
        nextButton.configuration?.buttonSize = .large
        nextButton.configuration?.cornerStyle = .capsule
        nextButton.addTarget(self, action: #selector(nextTapped), for: .primaryActionTriggered)

    }

    func layout() {
        stackView.addArrangedSubview(animationView)
        stackView.addArrangedSubview(label)

        view.addSubview(stackView)
        view.addSubview(nextButton)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            label.centerYAnchor.constraint(equalTo: stackView.centerYAnchor, constant: 250)
        ])

        // Next Buttton
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 4),
            nextButton.leadingAnchor.constraint(equalToSystemSpacingAfter: stackView.leadingAnchor, multiplier: 1),
            stackView.trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.trailingAnchor, multiplier: 1)
        ])
    }

    @objc func nextTapped(_ sender: UIButton) {
        if isLastPage {
            print("Bye")
            delegate?.didFinishOnboarding()
        } else {
            NotificationCenter.default.post(name: .nextButtonTapped, object: nil)
        }

    }

    @objc func doneTapped(_ sender: UIButton) {
        //delegate?.didFinishOnboarding()
    }
}

extension Notification.Name {
    static let nextButtonTapped = Notification.Name("nextButtonTapped")
}
