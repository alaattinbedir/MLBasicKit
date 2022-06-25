//
//  File.swift
//  
//
//  Created by Alaattin Bedir on 25.06.2022.
//

import UIKit
import MLExtensions

public enum EmbedController {
    case none
    case navigation
}

public enum NavigationOption {
    case none
    case pop
    case popPrevious(Int)
    case popAll

    public func navigate(viewController: UIViewController,
                         navigator: UINavigationController,
                         animated: Bool) {
        var viewControllers = navigator.viewControllers
        var willAppendViewController = true

        switch self {
        case .none:
            break
        case .pop:
            viewControllers.removeLast()
            willAppendViewController = false
        case let .popPrevious(count):
            viewControllers.removeLast(count)
        case .popAll:
            viewControllers.removeAll()
        }
        if !viewControllers.contains(viewController), willAppendViewController {
            viewControllers.append(viewController)
        }
        navigator.setViewControllers(viewControllers, animated: animated)
    }
}


public enum NavigationRouter {

    public static func go(to viewController: BaseDataVC,
                          embedController: EmbedController = .none,
                          data: ViewModelData? = nil,
                          transitionOptions: TransitionOptions) {

        if let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first {

            viewController.data = data
            let controller = NavigationRouter.getViewController(from: viewController,
                                                                embedController: embedController)

            keyWindow.setRootViewController(controller, options: transitionOptions)
        }
    }

    public static func present(from fromVC: UIViewController? = nil,
                               to toVC: BaseDataVC,
                               presentationStyle: UIModalPresentationStyle = .currentContext,
                               transitionStyle: UIModalTransitionStyle = .coverVertical,
                               willShowOverlay: Bool = false,
                               embedController: EmbedController = .none,
                               animated: Bool = true,
                               data: ViewModelData? = nil,
                               completion: (() -> Void)? = nil) {
        var presenterVC: UIViewController?
        if fromVC == nil {
            let topMostVC = getTopMostViewController()
            presenterVC = topMostVC
        } else {
            presenterVC = fromVC
        }

        toVC.data = data
        if presentationStyle == .overCurrentContext, willShowOverlay {
            presenterVC?.showOverlayView()
        }
        let controller = NavigationRouter.getViewController(from: toVC,
                                                            embedController: embedController)
        controller.modalPresentationStyle = presentationStyle
        controller.modalTransitionStyle = transitionStyle
        presenterVC?.present(controller, animated: animated, completion: completion)
    }

    public static func dismiss(viewController: UIViewController? = nil,
                               animated: Bool = true,
                               completion: (() -> Void)? = nil) {
        let aViewController = viewController ?? getTopMostViewController()
        aViewController?.presentingViewController?.currentViewController?.hideOverlayView()
        aViewController?.dismiss(animated: animated, completion: completion)
    }

    public static func push(from fromViewController: UIViewController,
                            to viewController: BaseDataVC,
                            animated: Bool = true,
                            navigationOption: NavigationOption = .none,
                            data: ViewModelData? = nil) {
        guard let navigator = fromViewController.navigationController else { return }
        viewController.data = data
        navigationOption.navigate(viewController: viewController, navigator: navigator, animated: animated)
    }

    public static func pop(viewController: UIViewController? = nil,
                           animated: Bool = true,
                           navigationOption: NavigationOption = .pop) {
        guard let navigator = (viewController ?? getTopMostViewController())?.navigationController else { return }
        guard let popViewController = viewController ?? navigator.viewControllers.last else { return }
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            navigationOption.navigate(viewController: popViewController,
                                      navigator: navigator,
                                      animated: animated)
        }
    }


    public static func getViewController(from viewController: UIViewController,
                                         embedController: EmbedController) -> UIViewController {
        switch embedController {
        case .none:
            return viewController
        case .navigation:
            return BaseNC(rootViewController: viewController)
        }
    }

    public static func getTopMostViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        return keyWindow?.topMostViewController()
    }

    public static func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
