import SwiftUI

struct BootArgsView: View {
    let bootArgs = "rd=disk0s1s3 amfi=0xff cs_enforcement_disable=1 debug=0x14e serial=3"

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Current Boot Args")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text(bootArgs)
                        .font(.system(.body, design: .monospaced))
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

                    Text("Kernel flags")
                        .font(.headline)

                    VStack(alignment: .leading, spacing: 8) {
                        InfoPill("amfi=0xff")
                        InfoPill("debug=0x14e")
                        InfoPill("serial=3")
                        InfoPill("cs_enforcement_disable=1")
                    }
                }
                .padding()
            }
            .navigationTitle("Boot Args")
        }
    }
}

private struct InfoPill: View {
    let value: String

    init(_ value: String) {
        self.value = value
    }

    var body: some View {
        Text(value)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(Color.blue.opacity(0.12))
            .foregroundStyle(.blue)
            .clipShape(Capsule())
    }
}
