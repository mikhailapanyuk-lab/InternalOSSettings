import SwiftUI
import Foundation

struct CoreOSView: View {
    @State private var deviceIdentifier: String = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    statusHeader()

                    sectionTitle("Internal", subtitle: "Core OS")

                    VStack(spacing: 0) {
                        SettingRow(label: "HW Model", value: getModelDisplayName())
                        SettingRow(label: "Kernel", value: "xnu-2423.1.73~3")
                        SettingRow(label: "iBoot", value: "iBoot-1940.10.58")
                        SettingRow(label: "Silicon", value: "Production")
                        SettingRow(label: "Identifier", value: deviceIdentifier.isEmpty ? "Loading..." : deviceIdentifier, isMasked: false)
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
                fetchDeviceIdentifier()
            }
        }
    }

    private func fetchDeviceIdentifier() {
        DispatchQueue.global(qos: .background).async {
            let value = getDeviceIdentifier()
            DispatchQueue.main.async {
                self.deviceIdentifier = value
            }
        }
    }

    private func getDeviceIdentifier() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)

        let machine = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                ptr in String(cString: ptr)
            }
        }

        return machine.isEmpty ? "Unknown" : machine
    }

    private func getModelDisplayName() -> String {
        let identifier = getDeviceIdentifier()

        let lookup: [String: String] = [
            "iPhone1,1": "iPhone",
            "iPhone1,2": "iPhone 3G",
            "iPhone2,1": "iPhone 3GS",
            "iPhone3,1": "iPhone 4",
            "iPhone3,2": "iPhone 4",
            "iPhone3,3": "iPhone 4 CDMA",
            "iPhone4,1": "iPhone 4S",
            "iPhone5,1": "iPhone 5",
            "iPhone5,2": "iPhone 5",
            "iPhone5,3": "iPhone 5c",
            "iPhone5,4": "iPhone 5c",
            "iPhone6,1": "iPhone 5s",
            "iPhone6,2": "iPhone 5s",
            "iPhone7,2": "iPhone 6",
            "iPhone7,1": "iPhone 6 Plus",
            "iPhone8,1": "iPhone 6s",
            "iPhone8,2": "iPhone 6s Plus",
            "iPhone8,4": "iPhone SE",
            "iPhone9,1": "iPhone 7",
            "iPhone9,3": "iPhone 7",
            "iPhone9,2": "iPhone 7 Plus",
            "iPhone9,4": "iPhone 7 Plus",
            "iPhone10,1": "iPhone 8",
            "iPhone10,2": "iPhone 8 Plus",
            "iPhone10,3": "iPhone X",
            "iPhone10,4": "iPhone 8",
            "iPhone10,5": "iPhone 8 Plus",
            "iPhone10,6": "iPhone X",
            "iPhone11,2": "iPhone XS",
            "iPhone11,4": "iPhone XS Max",
            "iPhone11,6": "iPhone XS Max",
            "iPhone11,8": "iPhone XR",
            "iPhone12,1": "iPhone 11",
            "iPhone12,3": "iPhone 11 Pro",
            "iPhone12,5": "iPhone 11 Pro Max",
            "iPhone12,8": "iPhone SE (2nd Gen)",
            "iPhone13,1": "iPhone 12 mini",
            "iPhone13,2": "iPhone 12",
            "iPhone13,3": "iPhone 12 Pro",
            "iPhone13,4": "iPhone 12 Pro Max",
            "iPhone14,2": "iPhone 13 Pro",
            "iPhone14,3": "iPhone 13 Pro Max",
            "iPhone14,4": "iPhone 13 mini",
            "iPhone14,5": "iPhone 13",
            "iPhone14,6": "iPhone SE (3rd Gen)",
            "iPhone14,7": "iPhone 14",
            "iPhone14,8": "iPhone 14 Plus",
            "iPhone15,2": "iPhone 14 Pro",
            "iPhone15,3": "iPhone 14 Pro Max",
            "iPhone15,4": "iPhone 15",
            "iPhone15,5": "iPhone 15 Plus",
            "iPhone16,1": "iPhone 15 Pro",
            "iPhone16,2": "iPhone 15 Pro Max",
            "iPhone17,1": "iPhone 16 Pro",
            "iPhone17,2": "iPhone 16 Pro Max",
            "iPhone17,3": "iPhone 16",
            "iPhone17,4": "iPhone 16 Plus"
        ]

        return lookup[identifier] ?? identifier
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
