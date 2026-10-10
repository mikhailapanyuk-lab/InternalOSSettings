import SwiftUI
import Foundation

struct CoreOSView: View {
    @State private var ecid: String = ""
    @State private var isLoading: Bool = true

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
                        SettingRow(label: "ECID", value: ecid.isEmpty ? "Fetching..." : ecid, isMasked: false)
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
                fetchDeviceECID()
            }
        }
    }

    private func fetchDeviceECID() {
        DispatchQueue.global(qos: .background).async {
            // Get ECID from device
            if let ecidValue = getDeviceECID() {
                DispatchQueue.main.async {
                    self.ecid = ecidValue
                }
            } else {
                // Fallback ECID for simulator or when not available
                DispatchQueue.main.async {
                    self.ecid = "0x0000000000000000"
                }
            }
        }
    }

    private func getDeviceECID() -> String? {
        // Try to get ECID from device
        // On real devices this would use private APIs, so we'll use a safe approach
        
        // For simulator or public API access, we can get a unique identifier
        if let uuid = UIDevice.current.identifierForVendor?.uuidString {
            // Convert UUID to hex-like format for visual appeal
            return "0x" + String(uuid.replacingOccurrences(of: "-", with: "").prefix(16)).uppercased()
        }
        
        return nil
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
