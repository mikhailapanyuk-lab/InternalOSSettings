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

            HardwareView()
                .tabItem {
                    Label("Hardware", systemImage: "memorychip")
                }
                .tag(1)

            DiagnosticsView()
                .tabItem {
                    Label("Diagnostics", systemImage: "stethoscope")
                }
                .tag(2)

            BootArgsView()
                .tabItem {
                    Label("Boot Args", systemImage: "terminal.fill")
                }
                .tag(3)
        }
        .tint(.blue)
    }
}
