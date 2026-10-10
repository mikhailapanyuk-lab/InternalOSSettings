import SwiftUI

@available(*, deprecated, message: "Use IBootView instead.")
struct LegacyBootView: View {
    var body: some View {
        IBootView()
    }
}

#Preview {
    LegacyBootView()
}
