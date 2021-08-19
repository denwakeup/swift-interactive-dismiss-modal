import Foundation
import SwiftUI

class InteractiveDismissModalHostingController<Content: View>: UIHostingController<Content>, UIAdaptivePresentationControllerDelegate {
    var canDismissSheet = true
    var onDismissalAttempt: (() -> ())?

    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)

        parent?.presentationController?.delegate = self
    }

    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        canDismissSheet
    }

    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        onDismissalAttempt?()
    }
}

struct InteractiveDismissModalView<T: View>: UIViewControllerRepresentable {
    let view: T
    let canDismissSheet: Bool
    let onDismissalAttempt: (() -> ())?

    func makeUIViewController(context: Context) -> InteractiveDismissModalHostingController<T> {
        let controller = InteractiveDismissModalHostingController(rootView: view)

        controller.canDismissSheet = canDismissSheet
        controller.onDismissalAttempt = onDismissalAttempt

        return controller
    }

    func updateUIViewController(_ uiViewController: InteractiveDismissModalHostingController<T>, context: Context) {
        uiViewController.rootView = view

        uiViewController.canDismissSheet = canDismissSheet
        uiViewController.onDismissalAttempt = onDismissalAttempt
    }
}

extension View {
    func interactiveDismiss(canDismissSheet: Bool, onDismissalAttempt: (() -> ())? = nil) -> some View {
        InteractiveDismissModalView(
            view: self,
            canDismissSheet: canDismissSheet,
            onDismissalAttempt: onDismissalAttempt
        ).edgesIgnoringSafeArea(.all)
    }
}
