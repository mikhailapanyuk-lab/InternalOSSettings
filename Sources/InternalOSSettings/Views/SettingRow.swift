import SwiftUI

struct SettingRow: View {
    let label: String
    let value: String
    var isMasked: Bool = false

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 17, weight: .regular))
                .foregroundStyle(.primary)

            Spacer()

            if isMasked {
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 120, height: 20)
                    .foregroundStyle(.black)
            } else {
                Text(value)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.primary)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemBackground))
    }
}
