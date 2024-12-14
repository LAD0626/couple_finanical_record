import SwiftUI
import UIKit

// 用UIViewControllerRepresentable來包裝UIKit界面
struct UIKitView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = mainViewController() // 這是你的UIViewController
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct ContentView: View {
    var body: some View {
        UIKitView() // 在SwiftUI中顯示UIKit界面
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
