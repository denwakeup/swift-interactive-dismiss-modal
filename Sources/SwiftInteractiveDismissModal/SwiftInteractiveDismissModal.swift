import Foundation
import SwiftUI
import UIKit

public class InteractiveDismissModalHostingController<Content: View>: UIHostingController<Content>, UIAdaptivePresentationControllerDelegate {
    var canDismissSheet = true
    var onDismissalAttempt: (() -> ())?

    public override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)

        parent?.presentationController?.delegate = self
    }

    public func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        canDismissSheet
    }

    public func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        onDismissalAttempt?()
    }
}

public struct InteractiveDismissModalView<T: View>: UIViewControllerRepresentable {
    let view: T
    let canDismissSheet: Bool
    let onDismissalAttempt: (() -> ())?

    public func makeUIViewController(context: Context) -> InteractiveDismissModalHostingController<T> {
        let controller = InteractiveDismissModalHostingController(rootView: view)

        controller.canDismissSheet = canDismissSheet
        controller.onDismissalAttempt = onDismissalAttempt

        return controller
    }

    public func updateUIViewController(_ uiViewController: InteractiveDismissModalHostingController<T>, context: Context) {
        uiViewController.rootView = view

        uiViewController.canDismissSheet = canDismissSheet
        uiViewController.onDismissalAttempt = onDismissalAttempt
    }
}

public extension View {
    func interactiveDismiss(canDismissSheet: Bool, onDismissalAttempt: (() -> ())? = nil) -> some View {
        InteractiveDismissModalView(
            view: self,
            canDismissSheet: canDismissSheet,
            onDismissalAttempt: onDismissalAttempt
        ).edgesIgnoringSafeArea(.all)
    }
}
