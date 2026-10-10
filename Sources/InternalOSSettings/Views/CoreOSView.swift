import SwiftUI
import Foundation

struct CoreOSView: View {
    @State private var deviceType: String = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    statusHeader()

                    sectionTitle("Internal", subtitle: "Core OS")

                    VStack(spacing: 0) {
                        SettingRow(label: "HW Model", value: "N41AP")
                        SettingRow(label: "Kernel", value: "xnu-2423.1.73~3")
                        SettingRow(label: "iBoot", value: "iBoot-1940.10.58")
                        SettingRow(label: "Silicon", value: "Production")
                        SettingRow(label: "Device", value: deviceType.isEmpty ? "Loading..." : deviceType, isMasked: false)
                    }
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                    warningCard()

                    actionButtonRow(title: "Brick Device")

                    bootArgsPreviewCard()
                }
                .padding(.bottom, 24)
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
            .onAppear {
                fetchDeviceType()
            }
        }
    }

    private func fetchDeviceType() {
        DispatchQueue.global(qos: .background).async {
            let type = getDeviceType()
            DispatchQueue.main.async {
                self.deviceType = type
            }
        }
    }

    private func getDeviceType() -> String {
        let device = UIDevice.current.userInterfaceIdiom

        switch device {
        case .phone:
            return "iPhone"
        case .pad:
            return "iPad"
        case .mac:
            return "Mac"
        case .tv:
            return "Apple TV"
        case .carPlay:
            return "CarPlay"
        case .vision:
            return "Vision Pro"
        @unknown default:
            return "Unknown Device"
        }
    }

    private func statusHeader() -> some View {
        HStack {
            Text("No SIM")
                .font(.system(size: 15, weight: .regular))
                .foregroundStyle(.primary)

            Spacer()

            Text(getCurrentTime())
                .font(.system(size: 15, weight: .regular))
                .foregroundStyle(.primary)

            HStack(spacing: 8) {
                Capsule()
                    .frame(width: 18, height: 12)
                    .foregroundStyle(.secondary)
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal, 18)
        .padding(.top, 14)
        .padding(.bottom, 6)
    }

    private func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: Date())
    }

    private func sectionTitle(_ title: String, subtitle: String) -> some View {
        HStack(spacing: 8) {
            Button {
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.blue)
            }

            Text(title)
                .font(.system(size: 20, weight: .regular))
                .foregroundStyle(.primary)

            Text(subtitle)
                .font(.system(size: 20, weight: .regular))
                .foregroundStyle(.primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.top, 8)
        .padding(.bottom, 8)
    }

    private func warningCard() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("WIPE YOUR DEVICE BEFORE RETURNING\nTO THE PERSON COLLECTING\nHARDWARE")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.primary)
                .multilineTextAlignment(.leading)
                .lineSpacing(1.8)
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }

    private func actionButtonRow(title: String) -> some View {
        Button {
        } label: {
            HStack {
                Text(title)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.blue)
                Spacer()
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 12)
        .padding(.horizontal, 16)
    }

    private func bootArgsPreviewCard() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("BOOT-ARGS")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.secondary)

            Text("rd=disk0s1s3 amfi=0xff cs_enforcement_disable=1 debug=0x14e serial=3")
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(.primary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 18)
        .padding(.top, 16)
        .padding(.bottom, 20)
    }
}
