//
//  OnboardingContainerViewController.swift
//  BankingClient
//
//  Created by Omar Khayyam on 2022-05-23.
//

import Foundation
import Lottie
import UIKit

class OnboardingContainerViewController: UIViewController {
    
    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    var currentVC: UIViewController {
        didSet {

        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        let page1 = ViewController1()
        let page2 = ViewController2()
        let page3 = ViewController3()

        pages.append(page1)
        pages.append(page2)
        pages.append(page3)

        currentVC = pages.first!

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemPurple

        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)

        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor)
        ])

        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        currentVC = pages.first!
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }

    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        currentVC = pages[index - 1]
        return pages[index - 1]
    }

    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}

// MARK: - ViewControllers
class ViewController1: UIViewController {
    let animationView = AnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMobileAnimation()
    }

    private func setupMobileAnimation() {
        animationView.animation = Animation.named("mobile")
        animationView.frame = view.bounds
        animationView.backgroundColor =  .white
        animationView.contentMode = .scaleAspectFit

        view.addSubview(animationView)

        DispatchQueue.main.async {
            self.animationView.currentProgress = 0
            self.animationView.play()
            self.animationView.loopMode = .loop
            self.animationView.backgroundBehavior = .pauseAndRestore
        }
    }
}

class ViewController2: UIViewController {
    let animationView = AnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPaymentAnimation()
    }

    private func setupPaymentAnimation() {
        animationView.animation = Animation.named("payments")
        animationView.frame = view.bounds
        animationView.backgroundColor = .white
        animationView.contentMode = .scaleAspectFit

        view.addSubview(animationView)

        DispatchQueue.main.async {
            self.animationView.currentProgress = 0
            self.animationView.play()
            self.animationView.loopMode = .loop
            self.animationView.backgroundBehavior = .pauseAndRestore
        }
    }
}

class ViewController3: UIViewController {
    let animationView = AnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppAnimation()

    }

   private func setupAppAnimation() {
       animationView.animation = Animation.named("app")
       animationView.frame = view.bounds
       animationView.backgroundColor = .white
       animationView.contentMode = .scaleAspectFit

       view.addSubview(animationView)

       DispatchQueue.main.async {
           self.animationView.currentProgress = 0
           self.animationView.play()
           self.animationView.loopMode = .loop
           self.animationView.backgroundBehavior = .pauseAndRestore
       }
    }
}
