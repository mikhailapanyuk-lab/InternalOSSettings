import SwiftUI

struct MainTabView: View {
    @State private var selection: Int = 0

    var body: some View {
        TabView(selection: $selection) {
            CoreOSView()
                .tabItem {
                    Label("Core OS", systemImage: "cpu")
                }
                .tag(0)

            KernelView()
                .tabItem {
                    Label("Kernel", systemImage: "terminal.fill")
                }
                .tag(1)

            SecurityView()
                .tabItem {
                    Label("Security", systemImage: "lock.shield")
                }
                .tag(2)

            IBootView()
                .tabItem {
                    Label("iBoot", systemImage: "bolt.fill")
                }
                .tag(3)

            HardwareView()
                .tabItem {
                    Label("Hardware", systemImage: "memorychip")
                }
                .tag(4)

            DiagnosticsView()
                .tabItem {
                    Label("Diagnostics", systemImage: "stethoscope")
                }
                .tag(5)
        }
        .tint(.blue)
    }
}
